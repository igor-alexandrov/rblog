class PostsController < ApplicationController
  #caches_action :show

# We don't want anybody anonymous to create new Posts.
# So in all child controllers this filter will work fine. 
  before_filter :check_for_abilities_to_create, :only => [:new, :create]

  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    if current_user
      @comment = UserComment.new
    else
      @comment = GuestComment.new
    end
    @comment.post = @post
  end

  def show_by_id
    @post = Post.find(params[:id])
    if @post
      redirect_to post_path(@post.permalink)
    end
  end

  def edit

  end

  def increase_rating
    unauthorized! if cannot? :change_rating_for, Post
    Post.increment_counter(:rating, params[:id] )
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def decrease_rating
    unauthorized! if cannot? :change_rating_for, Post
    Post.decrement_counter(:rating, params[:id] )
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
#      expire_fragment post_url(@post, :action_suffix => "tags")
      flash[:notice] = 'Post was successfully updated.'
      redirect_to post_path(@post)
    else
      render :action => "edit"
    end
  end

  private
  def check_for_abilities_to_create
    unauthorized! if cannot? :create, Post
  end
end
