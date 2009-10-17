class Admin::HomeController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"
    

  def index
    @posts = Post.find_all_by_status("published")
  end
end
