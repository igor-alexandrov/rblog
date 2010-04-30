class Posts::EventsController < PostsController
  def index
    @posts = Post.events.find(:all)
  end

  def new
    @event = Event.new
    @event.build_post(:content_type => "Event")
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def edit
    @event = Event.find(params[:id])
    @post = @event.post
    authorize! :edit, @post
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def create
    @event = Event.new(params[:event])
    @event.post.author = current_user
    if @event.save
      unless params[:mark_as_draf]
        @event.post.publish!
      end
      redirect_to post_path(@event.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])
    authorize! :edit, @event.post
    if @event.update_attributes(params[:event])
      unless params[:mark_as_draf]
        @event.post.publish!
      end
      redirect_to post_path(@event.post)
    else
      @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
      render :action => "edit"
    end

  end
end
