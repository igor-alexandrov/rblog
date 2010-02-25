class CommentsController < ApplicationController
#  before_filter :check_for_abilities_to_create, :only => [:new, :create]
  
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.new_comment( params[:parent_comment_id], current_user )
    unauthorized! if cannot? :create, @comment

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.create_comment(params[:comment], current_user)
    if current_user
      respond_to do |format|
        if @comment.save
          flash[:notice] = 'Comment was successfully created.'
          format.html {redirect_to post_url(@post, :anchor => dom_id(@comment))}
          format.js
        else
          format.html { render :action => "new" }
          format.js { render :action => "new" }
        end
      end
    else
      respond_to do |format|
        if Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide] and @comment.save
#        expire_fragment :controller => :posts, :action => :show, :id => @post.id
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
  end

  private
  def check_for_abilities_to_create

  end
end
