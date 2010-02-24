class Admin::HomeController < Admin::AdminController
  def index
    @posts = Post.find(:all)
  end
end
