class My::FavouritesController < My::NamespaceController
  def index
    @favourites = current_user.favourites
  end
end