class RepeatsController < ApplicationController
  # GET /repeats
  # GET /repeats.xml

  before_filter :authorize_admin

  def index
    @repeats = Repeat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @repeats }
    end
  end

  # GET /repeats/1
  # GET /repeats/1.xml
  def show
    @repeat = Repeat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @repeat }
    end
  end

  # GET /repeats/new
  # GET /repeats/new.xml
  def new
    @repeat = Repeat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @repeat }
    end
  end

  # GET /repeats/1/edit
  def edit
    @repeat = Repeat.find(params[:id])
  end

  # POST /repeats
  # POST /repeats.xml
  def create
    @repeat = Repeat.new(params[:repeat])

    respond_to do |format|
      if @repeat.save
        format.html { redirect_to(@repeat, :notice => 'Repeat was successfully created.') }
        format.xml  { render :xml => @repeat, :status => :created, :location => @repeat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @repeat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /repeats/1
  # PUT /repeats/1.xml
  def update
    @repeat = Repeat.find(params[:id])

    respond_to do |format|
      if @repeat.update_attributes(params[:repeat])
        format.html { redirect_to(@repeat, :notice => 'Repeat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @repeat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /repeats/1
  # DELETE /repeats/1.xml
  def destroy
    @repeat = Repeat.find(params[:id])
    @repeat.destroy

    respond_to do |format|
      format.html { redirect_to(repeats_url) }
      format.xml  { head :ok }
    end
  end
end
