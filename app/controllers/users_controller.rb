class UsersController < ApplicationController
  def index
    @users = User.by_reputation
  end

  def show
     
  end
end