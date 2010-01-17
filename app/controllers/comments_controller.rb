class CommentsController < ApplicationController
  before_filter :check_for_abilities_to_create, :only => [:new, :create]

  def index
    
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

    respond_to do |format|
      format.js{}
      format.html      
    end   
  end

  def create    
    @post = Post.find(params[:post_id])
    @comment = @post.add_comment(params[:comment])

    respond_to do |format|
      if Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide] and @comment.save
        expire_fragment :controller => :posts, :action => :show, :id => @post.id
        flash[:notice] = 'Comment was successfully created.'
        format.html {redirect_to post_url(@post, :anchor => dom_id(@comment))}
        format.js
      else
        @comment.errors.add("Word")
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        
        
        
      end
    end
  end

  private
  def check_for_abilities_to_create
    unauthorized! if cannot? :create, Comment
  end
end
