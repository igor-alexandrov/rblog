class My::HomeController < My::NamespaceController
  def index
    redirect_to my_profile_path
  end
end
