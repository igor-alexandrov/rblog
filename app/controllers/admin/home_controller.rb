class Admin::HomeController < Admin::AdminController
    layout "admin/application"

    def index
        @posts = Post.find_all_by_status("published")
    end
end
