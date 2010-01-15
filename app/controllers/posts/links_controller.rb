class Posts::LinksController < ApplicationController
  def new
    @link = Link.new
    @post = Post.topics.new
    @selectable_categories = Category.all.collect{ |c| [c.title, c.id] }
  end

  def index
  end

  def create
  end

end
