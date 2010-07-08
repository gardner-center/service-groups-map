class VisualizerController < ApplicationController


	#index should probably display an empty map 
	#with forms to search for activities
	#calculating nearby activities is an expensive operation, so hold out until the user makes a request
        #JBB - caching, prefetching?
  def index
    @user_zipcode = session[:user_zip] ||= "94305"
    @nearbyPrograms = Program.all #JBB placeholder for map to have something
    respond_to do |format|
      format.html 
    end
  end

  def new
    @nearbyPrograms = Program.all

  end

	#identify nearby programs here
        #JBB - value type coming in the form field will be a string "94305".to_i to convert to int
	def proximitySearch
    zipcode = 94305
    zip = Zip.code(zipcode)
    @nearbyPrograms = zip.programs
	end

end
