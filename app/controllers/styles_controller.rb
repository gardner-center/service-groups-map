class StylesController < ApplicationController
  # GET /styles
  # GET /styles.xml

  before_filter :authorize_admin

  def index
    @styles = Style.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @styles }
    end
  end

  # GET /styles/1
  # GET /styles/1.xml
  def show
    @style = Style.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @style }
    end
  end

  # GET /styles/new
  # GET /styles/new.xml
  def new
    @style = Style.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @style }
    end
  end

  # GET /styles/1/edit
  def edit
    @style = Style.find(params[:id])
  end

  # POST /styles
  # POST /styles.xml
  def create
    @style = Style.new(params[:style])

    respond_to do |format|
      if @style.save
        format.html { redirect_to(@style, :notice => 'Style was successfully created.') }
        format.xml  { render :xml => @style, :status => :created, :location => @style }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /styles/1
  # PUT /styles/1.xml
  def update
    @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update_attributes(params[:style])
        format.html { redirect_to(@style, :notice => 'Style was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1
  # DELETE /styles/1.xml
  def destroy
    @style = Style.find(params[:id])
    @style.destroy

    respond_to do |format|
      format.html { redirect_to(styles_url) }
      format.xml  { head :ok }
    end
  end
end
