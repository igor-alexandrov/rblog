class Admin::PagesController < Admin::AdminController
  add_breadcrumb "pages", "admin_pages_path"
  add_breadcrumb "new page", "new_admin_page_path", :only => [:new, :create]
  add_breadcrumb "edit page", "edit_admin_page_path", :only => [:edit, :update]

  cache_sweeper :pages_sweeper, :only => [ :create, :update ]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      notify :notice, 'page was successfully created'
      redirect_to admin_pages_path
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      notify :notice, 'page was successfully updated.'
      redirect_to admin_pages_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    unless @page.nil?
      @page.destroy
      notify :alert, 'page was destroyed.'
    end
    redirect_to admin_pages_path
  end

end
