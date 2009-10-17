class HomeController < ApplicationController
    def index
        @posts = Post.find_all_by_status("published")
    end
end
