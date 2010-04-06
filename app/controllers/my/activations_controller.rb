class My::ActivationsController < ApplicationController
  layout "application_centered"
  
  before_filter do |controller|
    controller.unauthorized! if controller.cannot? :access, :activations
  end

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?

    # @user.activate!(params)
  end

  def create
    @user = User.find_by_perishable_token(params[:perishable_token])

    raise Exception if @user.active?

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = "Your account has been activated."
      redirect_to my_profile_path
    else
      render :action => :new
    end
  end
end