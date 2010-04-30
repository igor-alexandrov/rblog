class Admin::HomeController < Admin::AdminController
  def index
    @posts = Post.all
  end
end
