class PostsController < ApplicationController
  #caches_action :show

  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    @comment = Comment.new
    @comment.post = @post
  end

  def increase_rating
    Post.increment_counter(:rating, params[:id] )
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def decrease_rating
    Post.decrement_counter(:rating, params[:id] )
    @post = Post.find(params[:id])    
    respond_to do |format|
      format.js
    end
  end

end
