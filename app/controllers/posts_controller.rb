class PostsController < ApplicationController
  #caches_action :show

  def show
    @post = Post.find(params[:id], :include => :comments)
    @comment = Comment.new
    @comment.post = @post
    
  end
end
