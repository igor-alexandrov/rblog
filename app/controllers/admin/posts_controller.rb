class Admin::PostsController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"

  def index
    @posts = Post.find(:all, :order => 'created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to admin_posts_path
    else
      render :action => "new"
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      expire_fragment post_url(@post, :action_suffix => "tags")
      flash[:notice] = 'Post was successfully updated.'
      redirect_to admin_posts_path
    else
      render :action => "edit"
    end

  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to(admin_posts_url) }
            
    end
  end

  def change_status
    puts params[:status]
  end
  
end


