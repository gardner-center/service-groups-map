class VisualizerController < ApplicationController

  before_filter :establish_session

  def index
    @user_zipcode = session[:user_zip]
    user_zip_like = @user_zipcode + "%"
    @nearbyPrograms = Program.where('zipcode like ?',user_zip_like)
    respond_to do |format|
      format.html 
    end
  end

  def find_programs
    @nearbyPrograms = [] #initialize
    if !(params[:zip].empty?) && (session[:user_zip] != params[:zip])
      @need_new_map = true
      change_of_zip(params[:zip])
    end
    @user_zipcode = session[:user_zip]
    user_zip_like = @user_zipcode.first(5) + "%" #So we find 10 digit zips with 5.
    age_min = params[:age_min] ||= "8"
    age_min = age_min.to_i - 1
    age_max = params[:age_max] ||= "14"
    age_max = age_max.to_i + 1
    @pre_sql = "zipcode like ? AND age_min > ? AND age_max < ?"
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
      @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like,age_min,age_max,@post_sql)
    else
      @nearbyPrograms = Program.where("#{@pre_sql}",user_zip_like,age_min,age_max)
    end

  end

  def find_programs_by_ajax

    #JBB the following are placeholder functions just to validate things are working
    @nearbyPrograms = Program.where('zipcode = ?',"94306")
    @change_zip_problem = true
    @user_zipcode = "JBB"

    respond_to do |format|
      format.html 
      format.js
    end
  end

  def advanced_find

  end

  def show_programs

  end

  private

  def change_of_zip(new_zip)
    begin
      zip = Zip.find_by_code(new_zip.first(5))
      session[:user_zip] = zip.code
      session[:lat] = zip.lat
      session[:lon] = zip.lon
    rescue
      @change_zip_problem = true #zip code not recognized
    end
  end

end
