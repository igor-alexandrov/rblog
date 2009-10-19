class Admin::HomeController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"
    

  def index
    @posts = Post.find(:all, :conditions => {:status => "published"}, :order => 'created_at')
  end
end
