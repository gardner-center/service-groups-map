class VisualizerController < ApplicationController


	#index should probably display an empty map 
	#with forms to search for activities
	#calculating nearby activities is an expensive operation, so hold out until the user makes a request
  def index
    @user_zipcode = session[:user_zip] ||= "94305"
    @nearbyPrograms = Zip.code(@user_zipcode).programs #JBB placeholder for map to have something
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    zipcode = 94305
    @nearbyPrograms = Zip.code(zipcode).programs

  end

	#identify nearby programs here
	def proximitySearch
    zipcode = 94305
    @nearbyPrograms = Zip.code(zipcode).programs
	end

end
