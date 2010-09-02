class ProgramsController < ApplicationController
  # GET /programs
  # GET /programs.xml

  before_filter :authorize_admin, :except => [:index, :show]

  def index
    @programs = Program.order('name ASC')
    @repeat_options = REPEATS_HASH

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programs }
    end
  end

  # GET /programs/1
  # GET /programs/1.xml
  def show
    begin
      @program = Program.find(params[:id])
      format_additional_areas_served
      load_many_to_many

      respond_to do |format|
        format.html 
        format.xml  { render :xml => @program }
      end
    rescue
      invalid_route
    end
  end

  # GET /programs/new
  # GET /programs/new.xml
  def new
    @program = Program.new
    @active_categories = []
    @active_styles = []
    @active_service_people = []
    @service_people = []
    @more_served_areas = ""

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @program }
    end
  end

  # GET /programs/1/edit
  def edit
    begin
      @program = Program.find(params[:id])
      @service_people = ServicePerson.where('service_group_id = ?',@program.service_group_id)
      format_additional_areas_served
      load_many_to_many
    rescue
      invalid_route
    end
  end

  # POST /programs
  # POST /programs.xml
  def create
    params[:program][:category_ids] ||= []
    params[:program][:cost] = "-1" if params[:program][:cost].downcase == "paid"
    params[:program][:cost] = "0" if params[:program][:cost].downcase == "free"
    params[:program][:cost].gsub!("$","") if params[:program][:cost][/\$/]
    #handle time inputs
    params[:program][:start_time] = format_time(params[:program][:start_time])
    params[:program][:end_time] = format_time(params[:program][:end_time])
    params[:program][:category_ids].count > 0 ? @is_category = true : @is_category = false
    params[:program][:service_group_id].to_i > 0 ? @is_group = true : @is_group = false
    #zipcode = params[:program][:zipcode]
    #zipcode = zipcode[0,5]
    #zip_obj = Zip.code(zipcode)
    #params[:program][:zip_id] = zip_obj.id unless zip_obj.nil?

    @program = Program.new(params[:program])
    begin
      @service_people = ServicePerson.where('service_group_id = ?',params[:program][:service_group_id])
    rescue
      @service_people = []
    end
    #zip_obj.programs.push(@program)
    #zip = Zip.code(@program.zipcode)
    #unless zip.nil?
    #{
    #  @program.zip_id = zip.id
      #zip.programs.push(@program) #JBB not sure what the intention was here. Jeff?
    #}
    
    load_many_to_many

    respond_to do |format|
      if @program.save && @is_category && @is_group
        handle_additional_areas_served
        format.html { redirect_to(@program, :notice => 'Program was successfully created.') }
        format.xml  { render :xml => @program, :status => :created, :location => @program }
      else
        @program.errors[:base] << 'Please assign one or more categories.' unless @is_category
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
    @service_people = ServicePerson.where('service_group_id = ?',@program.service_group_id)
    @more_served_areas = ""
    load_many_to_many

    params[:program][:cost] = "-1" if params[:program][:cost].downcase == "paid"
    params[:program][:cost] = "0" if params[:program][:cost].downcase == "free"
    params[:program][:cost].gsub!("$","") if params[:program][:cost][/\$/]
    #handle time inputs
    params[:program][:start_time] = format_time(params[:program][:start_time])
    params[:program][:end_time] = format_time(params[:program][:end_time])
    
    handle_additional_areas_served

    respond_to do |format|
      if @program.update_attributes(params[:program]) && params[:program][:category_ids].count > 0
        format.html { redirect_to(@program, :notice => 'Program was successfully updated.') }
        format.xml  { head :ok }
      else
        if params[:program][:category_ids].count < 1
          @program.errors[:base] << 'Please assign one or more categories.' 
        end
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

  def handle_additional_areas_served
    begin
      if params[:additional_zips] != params[:additional_zip_original] #remove old, add new
        #If program.update_attributes fails, these additional zips will have made it into the DB anyway
        #delete prior additionals
        result = ServedArea.delete_all(["program_id = ?",@program.id])
        params[:additional_zips].gsub(/\s/,"").split(",").each do |zip|
          if zip != @program.zipcode #no sense in storing it here if program already in that zip
            new_area = ServedArea.new
            new_area.program_id = params[:id]
            new_area.formatted_address = zip.first(5)
            new_area.save
            @more_served_areas += zip.first(5) + ","
          end
        end
       @more_served_areas.gsub!(/,$/,"") 
      end
    rescue
      @more_served_areas = ""
    end
  end

  def format_additional_areas_served
    additional_served_areas = ServedArea.where('program_id = ?',@program.id)
    @more_served_areas = ""
    for area in additional_served_areas
      @more_served_areas += area.formatted_address + ","
    end
    @more_served_areas.gsub!(/,$/,"")
  end

  def associate
    #JBB should not respond to non js queries
    #respond_to :js
    @active_service_people = []
    unless params[:service_group_id].nil? || params[:service_group_id] == ""
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
      render :nothing => true 
      #@service_group = ServiceGroup.first
      #@service_people = @service_group.service_persons
    end
    #  render(:update) do |page|
    #    page[:program_address1].value = @program.address1
    #  end
  end

  def format_time(time_string = "") #JBB check on this as default value
    @numeric_time = nil
    if time_string.length > 0
      time_string.downcase =~ /pm/ ? add_twelve = true : add_twelve = false
      time_string.gsub!(":",".")
      @numeric_time = time_string[/\d{1,2}(\.)?(\d{1,2})?/].to_f
      @numeric_time += 12 if add_twelve
    end
    @numeric_time
  end 
  

end
