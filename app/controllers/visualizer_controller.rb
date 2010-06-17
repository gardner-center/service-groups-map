class VisualizerController < ApplicationController

  def index
    @service_groups = ServiceGroup.all #JBB Limit may be desirable 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
