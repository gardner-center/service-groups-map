class ProgramsController < ApplicationController
  # GET /programs
  # GET /programs.xml

  before_filter :authorize_admin, :except => [:index, :show]

  def index
    @programs = Program.order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programs }
    end
  end

  # GET /programs/1
  # GET /programs/1.xml
  def show
    @program = Program.find(params[:id])
    load_many_to_many

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.xml
  def new
    @program = Program.new
    @active_categories = []
    @active_styles = []
    @active_service_people = []

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    load_many_to_many
  end

  # POST /programs
  # POST /programs.xml
  def create
    params[:program][:cost] = "-1" if params[:program][:cost].downcase == "paid"
    params[:program][:cost] = "0" if params[:program][:cost].downcase == "free"
    params[:program][:cost].gsub!("$","") if params[:program][:cost][/\$/]
    @program = Program.new(params[:program])
    zipcode = @program.zip
    zip = Zip.code(zipcode)
    if(!zip.nil?)
    {
      @program.zip_id = zip.id
      zip.programs.push(@program)
    }
    respond_to do |format|
      if @program.save
        format.html { redirect_to(@program, :notice => 'Program was successfully created.') }
        format.xml  { render :xml => @program, :status => :created, :location => @program }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.xml
  def update
    params[:program][:category_ids] ||= []
    @program = Program.find(params[:id])

    params[:program][:cost] = "-1" if params[:program][:cost].downcase == "paid"
    params[:program][:cost] = "0" if params[:program][:cost].downcase == "free"
    params[:program][:cost].gsub!("$","") if params[:program][:cost][/\$/]

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to(@program, :notice => 'Program was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.xml
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to(programs_url) }
      format.xml  { head :ok }
    end
  end

  def load_many_to_many
    @active_categories = []
    @program.categories.each do |cat|
      @active_categories << cat.id
    end
    @active_styles = []
    @program.styles.each do |style|
      @active_styles << style.id
    end
    @active_service_people = []
    @program.service_persons.each do |sp|
      @active_service_people << sp.id
    end
  end

  def associate
    #JBB should not respond to non js queries
    #respond_to :js
    @active_service_people = []
    unless params[:service_group_id].nil?
      @service_group = ServiceGroup.find(params[:service_group_id]) 
      @service_people = @service_group.service_persons
      if params[:program_id] == ""
        @active_service_people = [] 
      else
        Program.find(params[:program_id]).service_persons.each do |sp|
          @active_service_people << sp.id 
        end
      end
    else
      @service_group = ServiceGroup.first
      @service_people = @service_group.service_persons
    end
    #  render(:update) do |page|
    #    page[:program_address1].value = @program.address1
    #  end
  end

end
