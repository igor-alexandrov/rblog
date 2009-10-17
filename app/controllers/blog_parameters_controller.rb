class BlogParametersController < ApplicationController
  # GET /blog_parameters
  # GET /blog_parameters.xml
  def index
    @blog_parameters = BlogParameter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_parameters }
    end
  end

  # GET /blog_parameters/1
  # GET /blog_parameters/1.xml
  def show
    @blog_parameter = BlogParameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_parameter }
    end
  end

  # GET /blog_parameters/new
  # GET /blog_parameters/new.xml
  def new
    @blog_parameter = BlogParameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_parameter }
    end
  end

  # GET /blog_parameters/1/edit
  def edit
    @blog_parameter = BlogParameter.find(params[:id])
  end

  # POST /blog_parameters
  # POST /blog_parameters.xml
  def create
    @blog_parameter = BlogParameter.new(params[:blog_parameter])

    respond_to do |format|
      if @blog_parameter.save
        flash[:notice] = 'BlogParameter was successfully created.'
        format.html { redirect_to(@blog_parameter) }
        format.xml  { render :xml => @blog_parameter, :status => :created, :location => @blog_parameter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog_parameter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blog_parameters/1
  # PUT /blog_parameters/1.xml
  def update
    @blog_parameter = BlogParameter.find(params[:id])

    respond_to do |format|
      if @blog_parameter.update_attributes(params[:blog_parameter])
        flash[:notice] = 'BlogParameter was successfully updated.'
        format.html { redirect_to(@blog_parameter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog_parameter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_parameters/1
  # DELETE /blog_parameters/1.xml
  def destroy
    @blog_parameter = BlogParameter.find(params[:id])
    @blog_parameter.destroy

    respond_to do |format|
      format.html { redirect_to(blog_parameters_url) }
      format.xml  { head :ok }
    end
  end
end
