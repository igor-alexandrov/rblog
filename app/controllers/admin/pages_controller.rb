class Admin::PagesController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"

  def index
    @pages = Page.roots
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      redirect_to admin_pages_path
    else
      render :action => "edit"
    end
  end

  def destroy
    
  end

end
