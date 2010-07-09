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

	#identify nearby programs here
  #JBB - value type coming in the form field will be a string "94305".to_i to convert to int
	def proximitySearch
    #zipcode = params[:input][:zipcode]
    zipcode = params[:address]
    if(zipcode.length >=5)
      @nearbyPrograms = Zip.code(zipcode).programs
    else @nearbyPrograms = []
    end
	end

end
