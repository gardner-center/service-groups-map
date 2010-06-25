class ServicePeopleController < ApplicationController
  # GET /service_people
  # GET /service_people.xml

  before_filter :authorize_admin, :except => [:index, :show]

  def index
    @service_people = ServicePerson.order('last_name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_people }
    end
  end

  # GET /service_people/1
  # GET /service_people/1.xml
  def show
    begin
      @service_person = ServicePerson.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @service_person }
      end
    rescue
      invalid_route
    end
  end

  # GET /service_people/new
  # GET /service_people/new.xml
  def new
    @service_person = ServicePerson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_person }
    end
  end

  # GET /service_people/1/edit
  def edit
    begin
      @service_person = ServicePerson.find(params[:id])
    rescue
      invalid_route
    end
  end

  # POST /service_people
  # POST /service_people.xml
  def create
    @service_person = ServicePerson.new(params[:service_person])

    respond_to do |format|
      if @service_person.save
        format.html { redirect_to(@service_person, :notice => 'Service person was successfully created.') }
        format.xml  { render :xml => @service_person, :status => :created, :location => @service_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_people/1
  # PUT /service_people/1.xml
  def update
    @service_person = ServicePerson.find(params[:id])

    respond_to do |format|
      if @service_person.update_attributes(params[:service_person])
        format.html { redirect_to(@service_person, :notice => 'Service person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_people/1
  # DELETE /service_people/1.xml
  def destroy
    @service_person = ServicePerson.find(params[:id])
    @service_person.destroy

    respond_to do |format|
      format.html { redirect_to(service_people_url) }
      format.xml  { head :ok }
    end
  end
end
