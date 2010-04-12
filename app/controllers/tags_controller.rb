class TagsController < ApplicationController
  def show
    @posts = Post.published_with_tag( params[:name], :page => params[:page] )
  end
end
