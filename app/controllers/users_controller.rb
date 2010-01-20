class UsersController < ApplicationController

  def index
    @users = User.by_reputation
  end

  def show

  end

  def new
    self.class.layout "login"
    @user = User.new
  end

  def create
    self.class.layout "login"

  end

end