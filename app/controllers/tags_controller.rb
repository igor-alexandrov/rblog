class TagsController < ApplicationController
  def show
    @posts = Post.published.tagged_with(params[:name])
  end
end
