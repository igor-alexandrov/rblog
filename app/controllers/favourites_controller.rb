class FavouritesController < ApplicationController
  before_filter :require_user
  def index
    @favourites = current_user.favourites
  end
end