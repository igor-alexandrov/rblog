class Admin::BlogParametersController < Admin::AdminController 
  before_filter :require_user
  layout "admin/application"
  
  def index
    @blog_parameters = BlogParameter.all 
  end

  
end
