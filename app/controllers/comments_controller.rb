class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def new
    @post = Post.find(params[:post_id])
    #@parent_comment = Comment.find(params[:parent_comment_id])
    @comment = Comment.new(params[:comment_id])
    @comment.parent_comment_id = params[:parent_comment_id]

    respond_to do |format|
      format.js{}
      format.html      
    end   
  end

  def create    
    @post = Post.find(params[:post_id])
    @comment = @post.add_comment(params[:comment])

    respond_to do |format|
      if @comment.save
        expire_action :controller => :posts, :action => :show, :id => @post.id
        flash[:notice] = 'Comment was successfully created.'
        format.html {redirect_to post_path(@comment.post)}
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end
end
