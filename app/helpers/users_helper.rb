module UsersHelper
  def render_user_screen_name_with_avatar(user)
    render :partial => "users/screen_name_with_avatar", :locals => {:user => user}
  end
  
  def render_social_connections(user)
    render :partial => "users/social_connections", :locals => {:user => user}
  end
end