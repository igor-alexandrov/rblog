class Admin::UsersController < Admin::AdminController
  before_filter :require_user
  layout "admin/application"

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:post])

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'user was successfully updated.'
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end

end
