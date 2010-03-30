class UsersController < ApplicationController

  def index
    @users = User.by_reputation
  end

  def show
    @user = User.find_by_login(params[:id])
    redirect_to my_profile_path if @user == current_user
  end

  def new
    self.class.layout "login"
    @user = User.new
  end

  def create
    self.class.layout "login"

  end

end