# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user

  
#  rescue_from CanCan::AccessDenied do |exception|
#    flash[:error] = "У вас недостаточно прав для просмотра запрошенной страницы."
#    redirect_back_or_default root_path_for_user(current_user)

#    redirect_to root_path
#  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
