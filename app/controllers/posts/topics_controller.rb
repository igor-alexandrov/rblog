class Posts::TopicsController < PostsController
  def index
    @posts = Post.topics.find(:all)
  end

  def new
    @topic = Topic.new
    @post = Post.topics.new
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def create
    @post = Post.new(params[:topic][:post])
    @post.author = current_user
    params[:topic].delete(:post)

    @topic = Topic.new(params[:topic])
    if @topic.save
      @post.content = @topic
      if @post.save
        @post.publish!
        redirect_to root_url
      else
        @topic.delete
        @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
        render :action => :new
      end
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => :new
    end
  end

  def update

  end
end
