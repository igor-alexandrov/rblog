class HomeController < ApplicationController
    def index
        @posts = Post.published
    end
end
