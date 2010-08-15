class VisualizerController < ApplicationController

  #------------------------------------------------------------------
  #Note that cookie[:user_zip] is being used to house full addresses
  #cookie[:user_just_zip] stores only the 5 digit zip code if 
  #available.
  #Current db query assumes lat/lon values in the cookie and uses a 
  #delta to build an initial list of nearby programs which is then
  #culled based on the search radius specified
  #------------------------------------------------------------------

  before_filter :establish_cookie

  include Distance
  
  def index
    @user_zipcode = cookies[:user_zip]
    @nearbyPrograms = Program.where("lat > (? - #{LATLON_DELTA}) AND 
                                     lat < (? + #{LATLON_DELTA}) AND 
                                     lon > (? - #{LATLON_DELTA}) AND 
                                     lon < (? + #{LATLON_DELTA})",
                                     @user_lat,@user_lat,@user_lon,@user_lon)
#JBB can take these ids and add OR IN (2,3,4 - whatever is in additional_area_ids) to sql above
    additional_area_ids = ServedArea.select('program_id').where("
                                     lat > (? - #{LATLON_DELTA}) AND 
                                     lat < (? + #{LATLON_DELTA}) AND 
                                     lon > (? - #{LATLON_DELTA}) AND 
                                     lon < (? + #{LATLON_DELTA})",
                                     @user_lat,@user_lat,@user_lon,@user_lon)
    cull_based_on_proximity #See if within radius and delete if not

    respond_to do |format|
      format.html 
    end
  end

  def find_programs
    @notes = ""  #Use this to help people if they do things like specify a min_age > max_age
    @nearbyPrograms = [] #initialize
    @need_new_map = false #initialize

    if !(params[:zip].empty?) && (cookies[:user_zip] != params[:zip])
      change_of_zip(params[:zip])
    end
    @user_zipcode = cookies[:user_zip]
    @pre_sql = "lat > (? - #{LATLON_DELTA}) AND 
                lat < (? + #{LATLON_DELTA}) AND 
                lon > (? - #{LATLON_DELTA}) AND 
                lon < (? + #{LATLON_DELTA})"
    unless params[:age_any] 
      age_min = params[:age_min] ||= "8"
      age_min = age_min.to_i - 1
      age_max = params[:age_max] ||= "14"
      age_max = age_max.to_i + 1
      if age_max >= age_min
        @pre_sql += " AND age_min > ? AND age_max < ?"
      else
        @notes += "Age criteria was not used because a minimum age greater than or equal to a maximum age would yied no results."
      end
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
      #get eligible programs serving those categories. JBB: This searches over all programs now. 
      #Would be more efficient to search within local area
      @progs_with_cats = Program.find_by_sql("select distinct program_id from categories_programs where category_id IN (#{@cat_ids})")
      for prog in @progs_with_cats
        @prog_ids += prog.program_id.to_s + ","
      end
      @prog_ids.gsub!(/,$/,"") #remove trailing ","
      @pre_sql += " AND id IN (#{@prog_ids})"
    end
    #Repeats criteria
    unless params[:program][:repeats] == "any"
      @pre_sql += " AND repeats = ?"
      @post_sql = "#{params[:program][:repeats]}"
    end
    #Time criteria
    unless params[:start_time] == "any" && params[:end_time] == "any"
      begin
        #discard unless end_time after start time
        if params[:start_time].to_i < params[:end_time].to_i
          st = params[:start_time].to_i - 2
          @pre_sql += " AND start_time > #{st}" unless st < 0
          et =  params[:end_time].to_i + 2
          @pre_sql += " AND end_time < #{et}" unless et < 0
        else
          @notes += " The time criteria was not used because it is not valid to have the end time fall before the start time."
        end
      rescue
        #proceed
      end
    end
    #@nearbyPrograms = Program.where("#{@pre_sql}",@post_sql)
    if @pre_sql =~ /age/
      if @post_sql.empty?
        @nearbyPrograms = Program.where("#{@pre_sql}",@user_lat,@user_lat,@user_lon,@user_lon,age_min,age_max)
      else
        @nearbyPrograms = Program.where("#{@pre_sql}",@user_lat,@user_lat,@user_lon,@user_lon,age_min,age_max,@post_sql)
      end
    else
      if @post_sql.empty?
        @nearbyPrograms = Program.where("#{@pre_sql}",@user_lat,@user_lat,@user_lon,@user_lon)
      else
        @nearbyPrograms = Program.where("#{@pre_sql}",@user_lat,@user_lat,@user_lon,@user_lon,@post_sql)
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
    #get lat/lon and add to cookies
    respond_to do |format|
      format.js do
        begin
          address = params[:zip_mirror] #JBB some potential for a lag problem where mirror value 
                                        #not created fast enough, so get old value
          if address != cookies[:user_zip]
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
                if address[/(\d{5})(-\d{4})?(.{2,20})?$/]
                  session[:user_just_zip_staged] = $1
                end
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

  def decline_instructions
    cookies.permanent[:show_instructions] = false
    render(:update) do |page|
      page[:instructions].hide
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
        cookies[:user_zip] = session[:user_zip_staged]
        cookies[:user_just_zip] = session[:user_just_zip_staged]
        @user_lat = cookies[:lat] = session[:lat_staged]
        @user_lon = cookies[:lon] = session[:lon_staged]
        session.delete(:user_zip_staged) #if session[:user_zip_staged]
        session.delete(:lat_staged) #if session[:lat_staged]
        session.delete(:lon_staged) #if session[:lon_staged]
        session.delete(:user_just_zip_staged) #if session[:user_just_zip_staged]
      elsif (new_zip.length <= 10) && (new_zip.first(5).to_i > 0)
        #no preprocessing,so we will do geocoding.  This is for zip code only entry  
        zip = Zip.find_by_code(new_zip.first(5))
        cookies[:user_zip] = cookies[:user_just_zip] = zip.code
        @user_lat = cookies[:lat] = zip.lat
        @user_lon = cookies[:lon] = zip.lon
      else
        #Assume full address
        geocoordinates = get_lat_lon(new_zip)
        unless geocoordinates.empty?
          cookies[:user_zip] = new_zip
          if new_zip[/(\d{5})(-\d{4})?(.{2,20})?$/]
            cookies[:user_just_zip] = $1
          end
          @user_lat = cookies[:lat] = geocoordinates[:lat]
          @user_lon = cookies[:lon] = geocoordinates[:lon]
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
      order_by_dist_asc = {}
      index = 0
      for program in @nearbyPrograms
        dist = distance(@user_lat,@user_lon,program.lat,program.lon,"M")
        if dist > @user_radius
          @nearbyPrograms.delete_at(index)
          index -= 1
        else
          #add to hash for sorting by distance
          order_by_dist_asc[dist] = program
        end
        index += 1
      end
      #Rebuilt array from hash according to distance, ASC
      @nearbyPrograms = []
      order_by_dist_asc.keys.sort.each do |key|
        @nearbyPrograms.push(order_by_dist_asc[key])
      end
    end
  end

end
