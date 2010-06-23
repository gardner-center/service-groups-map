class VisualizerController < ApplicationController


	#index should probably display an empty map 
	#with forms to search for activities
	#calculating nearby activities is an expensive operation, so hold out until the user makes a request
  def index
    @nearbyPrograms = Program.all #JBB placeholder for map to have something
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

	#identify nearby programs here
	def search
		allPrograms = Program.find(:all) #JBB placeholder for map to have something
    nearbyPrograms = []
    
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html # index.html.erb
    end
	end

end
