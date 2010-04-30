class Posts::TopicsController < PostsController
  def index
    @posts = Post.topics.all
  end

  def new
    @topic = Topic.new
    @topic.build_post(:content_type => "Topic")
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def edit
    @topic = Topic.find(params[:id])
    @post = @topic.post
    authorize! :edit, @post
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.post.author = current_user
    if @topic.save
       redirect_to post_path(@topic.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :edit, @topic.post    
    if @topic.update_attributes(params[:topic])
      redirect_to post_path(@topic.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "edit"
    end

  end
end
