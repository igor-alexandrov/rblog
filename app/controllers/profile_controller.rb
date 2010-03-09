class ProfileController < ApplicationController
  before_filter :require_user

  def view
    @user = current_user
  end
end
