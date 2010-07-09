class VisualizerController < ApplicationController


	#index should probably display an empty map 
	#with forms to search for activities
	#calculating nearby activities is an expensive operation, so hold out until the user makes a request
        #JBB - caching, prefetching?
  def index
    @user_zipcode = session[:user_zip] ||= "94305"
    @nearbyPrograms = Zip.code(@user_zipcode).programs #JBB placeholder for map to have something
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html 
    end
  end

  def new
    zipcode = 94305
    @nearbyPrograms = Zip.code(zipcode).programs
  end

  def find_programs
    @nearbyPrograms = [] #initialize
    session[:user_zip] = params[:zip] ||= session[:user_zip]
    @user_zipcode = session[:user_zip]
    user_zip_like = @user_zipcode + "%" #So we find 10 digit zips with 5.
    age_min = params[:age_min] ||= "8"
    age_min = age_min.to_i - 1
    age_max = params[:age_max] ||= "14"
    age_max = age_max.to_i + 1
    @pre_sql = "zipcode like ? AND age_min > ? AND age_max < ?"
    @post_sql = ""

    @cat_ids = ""
    @prog_ids = ""
    #Prepare for search by category
    unless params[:program][:category_ids].nil?
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

  def advanced_find

  end

  def show_programs

  end

	#identify nearby programs here
  #JBB - value type coming in the form field will be a string "94305".to_i to convert to int
	def proximitySearch
    #zipcode = params[:input][:zipcode]
    zipcode = params[:zip]
    if(zipcode.length >=5)
      @nearbyPrograms = Zip.code(zipcode).programs
    else @nearbyPrograms = []
    end
	end

end
