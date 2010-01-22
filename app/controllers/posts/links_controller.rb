class Posts::LinksController < PostsController
  def index
    @posts = Post.links.find(:all)
  end

  def new
    @link = Link.new
    @link.build_post(:content_type => "Link")
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def edit
    @link = Link.find(params[:id])
    @post = @link.post
    unauthorized! if cannot? :edit, @post
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def create
    @link = Link.new(params[:link])
    @link.post.author = current_user
    if @link.save
       redirect_to post_path(@link.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "new"
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to post_path(@link.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "edit"
    end

  end
end
