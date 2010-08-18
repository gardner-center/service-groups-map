class ServiceGroupsController < ApplicationController
  # GET /service_groups
  # GET /service_groups.xml

  before_filter :authorize_admin, :except => [:index, :show]

  def index
    @service_groups = ServiceGroup.order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_groups }
    end
  end

  # GET /service_groups/1
  # GET /service_groups/1.xml
  def show
    begin
      @service_group = ServiceGroup.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @service_group }
      end
    rescue
      invalid_route
    end
  end

  # GET /service_groups/new
  # GET /service_groups/new.xml
  def new
    @service_group = ServiceGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_group }
    end
  end

  # GET /service_groups/1/edit
  def edit
    begin
      @service_group = ServiceGroup.find(params[:id])
    rescue
      invalid_route
    end
  end

  # POST /service_groups
  # POST /service_groups.xml
  def create
    @service_group = ServiceGroup.new(params[:service_group])

    respond_to do |format|
      if @service_group.save
        format.html { redirect_to(@service_group, :notice => 'Service group was successfully created.') }
        format.xml  { render :xml => @service_group, :status => :created, :location => @service_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_groups/1
  # PUT /service_groups/1.xml
  def update
    @service_group = ServiceGroup.find(params[:id])

    respond_to do |format|
      if @service_group.update_attributes(params[:service_group])
        format.html { redirect_to(@service_group, :notice => 'Service group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_groups/1
  # DELETE /service_groups/1.xml
  def destroy
    @service_group = ServiceGroup.find(params[:id])
    result = @service_group.destroy
    flash[:notice] = @service_group.errors[:base][0] if result == false

    respond_to do |format|
      format.html { redirect_to(service_groups_url) }
      format.xml  { head :ok }
    end
  end
end
