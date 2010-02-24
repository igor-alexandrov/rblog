class Admin::BlogParametersController < Admin::AdminController   
  def index
    @blog_parameters = BlogParameter.all 
  end
end
