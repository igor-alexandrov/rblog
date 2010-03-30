class My::ProfileController < My::NamespaceController
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
end
