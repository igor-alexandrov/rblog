class CommentsController < ApplicationController

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

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
#    if @comment.parent_comment_id.nil?
#      @comment.parent_comment_id = 0
#    end
    respond_to do |format|
      format.js{  }
      format.html
      
    end
    
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.add_comment(params[:comment], params[:parent_comment_id])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html {redirect_to post_path(@comment.post)}
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
