class VisualizerController < ApplicationController

  #------------------------------------------------------------------
  #Note that session[:user_zip] is being used to house full addresses
  #session[:user_just_zip] stores only the 5 digit zip code
  #------------------------------------------------------------------

  before_filter :establish_session

  include Distance
  
  def index
    @user_zipcode = session[:user_just_zip]
    user_zip_like = @user_zipcode.first(2) + "%"
    @nearbyPrograms = Program.where('zipcode like ?',user_zip_like)
    cull_based_on_proximity #See if within radius and delete if not

    respond_to do |format|
      format.html 
    end
  end

  def find_programs
    @nearbyPrograms = [] #initialize
    @need_new_map = false #initialize

    if !(params[:zip].empty?) && (session[:user_zip] != params[:zip])
      change_of_zip(params[:zip])
    end
    @user_zipcode = session[:user_zip]
    user_zip_like = session[:user_just_zip].first(2) + "%" #So we find 10 digit zips with 5.
    if params[:age_any] #not posted if unchecked
      @pre_sql = "zipcode like ?"
    else
      age_min = params[:age_min] ||= "8"
      age_min = age_min.to_i - 1
      age_max = params[:age_max] ||= "14"
      age_max = age_max.to_i + 1
      @pre_sql = "zipcode like ? AND age_min > ? AND age_max < ?"
    end
    @post_sql = ""

    @cat_ids = ""
    @prog_ids = ""
    #Prepare for search by category
    unless params[:program].nil? || params[:program][:category_ids].nil?
      for cat_id in params[:program][:category_ids]
        #set up join with program_id_category_id table
        @cat_ids += cat_id.to_i.to_s + ","
      end
      @cat_ids.gsub!(/,$/,"") #remove trailing ","
      #get eligible programs serving those categories
      @progs_with_cats = Program.find_by_sql("select distinct program_id from categories_programs where category_id IN (#{@cat_ids})")
      for prog in @progs_with_cats
        @prog_ids += prog.program_id.to_s + ","
      end
      @prog_ids.gsub!(/,$/,"") #remove trailing ","
      @pre_sql += " AND id IN (#{@prog_ids})"
    end
    unless params[:program][:repeats] == "any"
      @pre_sql += " AND repeats = ?"
      @post_sql = "#{params[:program][:repeats]}"
    end
    unless params[:start_time] == "any"
      begin
        #discard unless end_time after start time
        if params[:start_time].to_i < params[:end_time].to_i
          st = params[:start_time].to_i - 2
          et =  params[:end_time].to_i + 2
          st.to_s
          et.to_s
          @pre_sql += " AND start_time > #{st} AND end_time < #{et}"
        end
      rescue
        #proceed
      end
    end

    #@nearbyPrograms = Program.where("#{@pre_sql}",@post_sql)
    if @cat_ids.length > 1
      if @pre_sql =~ /age/
        @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like,age_min,age_max,@post_sql)
      else
        @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like,@post_sql)
      end
    else
      if @pre_sql =~ /age/
        @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like,age_min,age_max)
      else
        @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like)
      end
    end
    cull_based_on_proximity #See if within radius and delete if not

    respond_to do |format|
      format.html 
      format.js
    end
  
  end

  def find_lat_lon
    #pull address from address in form
    #get lat/lon and add to session
    respond_to do |format|
      format.js do
        begin
          address = params[:zip_mirror] #JBB some potential for a lag problem where mirror value 
                                        #not created fast enough, so get old value
          if address != session[:user_zip]
            if (address.length <= 10) && (address.first(5).to_i > 0)
              #assume zip only
              zip = Zip.find_by_code(address.first(5))
              session[:user_zip_staged] = zip.code
              session[:user_just_zip_staged] = zip.code
              session[:lat_staged] = zip.lat
              session[:lon_staged] = zip.lon
            else
              #assume full address
              geocoordinates = get_lat_lon(address)
              unless geocoordinates.empty?
                session[:user_zip_staged] = address
                session[:user_just_zip_staged] = address[/\d{5}(-\d{4})?(.{2,20})?$/].first(5)
                session[:lat_staged] = geocoordinates[:lat]
                session[:lon_staged] = geocoordinates[:lon]
              end
            end
          end
        rescue
          #nothing to do then
        end
        render :nothing => true
      end
    end
  end

  def advanced_find

  end

  def show_programs

  end

  private

  def change_of_zip(new_zip)
    begin
      if session[:lat_staged]
        #the preprocessing of the zip/address field has happened and we can use that data
        session[:user_zip] = session[:user_zip_staged]
        session[:user_just_zip] = session[:user_just_zip_staged]
        @user_lat = session[:lat] = session[:lat_staged]
        @user_lon = session[:lon] = session[:lon_staged]
        session.delete(:user_zip_staged) #if session[:user_zip_staged]
        session.delete(:lat_staged) #if session[:lat_staged]
        session.delete(:lon_staged) #if session[:lon_staged]
        session.delete(:user_just_zip_staged) #if session[:user_just_zip_staged]
      elsif (new_zip.length <= 10) && (new_zip.first(5).to_i > 0)
        #no preprocessing,so we will do geocoding.  This is for zip code only entry  
        zip = Zip.find_by_code(new_zip.first(5))
        session[:user_zip] = session[:user_just_zip] = zip.code
        @user_lat = session[:lat] = zip.lat
        @user_lon = session[:lon] = zip.lon
      else
        #Assume full address
        geocoordinates = get_lat_lon(new_zip)
        unless geocoordinates.empty?
          session[:user_zip] = new_zip
          session[:user_just_zip] = new_zip[/\d{5}(-\d{4})?(.{2,20})?$/].first(5)
          @user_lat = session[:lat] = geocoordinates[:lat]
          @user_lon = session[:lon] = geocoordinates[:lon]
        else
          raise
        end
      end
      @need_new_map = true
      @change_zip_problem = false
    rescue
      @change_zip_problem = true #zip code not recognized
    end
  end

  def cull_based_on_proximity
    if @nearbyPrograms
      index = 0
      for program in @nearbyPrograms
        dist = distance(session[:lat],session[:lon],program.lat,program.lon,"M")
        if dist > session[:radius]
          @nearbyPrograms.delete_at(index)
          index -= 1
        end
        index += 1
      end
    end
  end

end
