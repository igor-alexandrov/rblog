class HomeController < ApplicationController
    def index
        @posts = Post.find(:all, :conditions => {:status => "published"}, :order => 'created_at DESC', :include => [:category, :author, :tags])
    end
end
