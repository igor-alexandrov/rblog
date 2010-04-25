class UsersController < ApplicationController
  def index
    @users = User.by_reputation
  end

  def show
    @user = User.find_by_login(params[:id])
    redirect_to my_profile_path if @user == current_user
  end

  def new
    @user = User.new
    render :layout => "application_centered"
  end

  def create
    @user = User.new

    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => :new, :layout => "application_centered"
    end
  end
end