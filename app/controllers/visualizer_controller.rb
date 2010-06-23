class VisualizerController < ApplicationController


  def index
    @nearbyPrograms = Program.all #JBB placeholder for map to have something
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
