class HomeController < ApplicationController
    def index
        @posts = Post.find(:all, :conditions => {:status => "published"}, :order => 'created_at DESC')
    end
end
