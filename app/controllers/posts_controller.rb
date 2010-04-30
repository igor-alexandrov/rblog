class PostsController < ApplicationController
# We don't want anybody anonymous to create new Posts.
# So in all child controllers this filter will work fine. 
  before_filter :check_for_abilities_to_create, :only => [:new, :create]

  cache_sweeper :posts_sweeper, :only => [ :update ]

  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    @comments = @post.comments
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
    authorize! :change_rating_for, Post
    Post.increment_counter(:rating, params[:post_id] )
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js
    end
  end

  def decrease_rating
    authorize! :change_rating_for, Post
    Post.decrement_counter(:rating, params[:post_id] )
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js
    end
  end

  def toggle_favourite
    @post = Post.find(params[:post_id])
    if current_user.has_favourite?(@post)
      current_user.remove_favourite!(@post)
    else
      current_user.add_favourite!(@post)
    end
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
    authorize! :create, Post
  end
end
