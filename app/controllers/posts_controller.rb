class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new


    unless params[:comment].blank?
      @comment = Comment.new
      @comment.post = @post
      @comment.parent_comment_id = params[:comment][:parent_comment_id]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
end
