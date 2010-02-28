class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  before_filter do |controller|
    unless controller.class.to_s == "UserSessionsController"
      controller.store_location
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    notify :error, "You are not authorized to access page, that you requested"
    if current_user
      session[:return_to] = nil
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private
  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_back_or_default root_path
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = "You must be logged out to access this page"
      redirect_back_or_default root_path
      return false
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def notify(type, message)
    flash[:notifications] ||= {}
    flash[:notifications][type] = message
    logger.error("ERROR: #{message}") if type == :error
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

end
