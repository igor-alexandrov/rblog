class Admin::UsersController < Admin::AdminController
  add_breadcrumb "users", "admin_users_path"
  add_breadcrumb "new user", "new_admin_user_path", :only => [:new, :create]

  def index
    @search = User.search(params[:search])
    @users = @search.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to admin_user_path(@user)
    else
      render :action => "new"
    end
  end

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update

  end

  def destroy
    @user = User.find_by_login(params[:id])
    unless @user.nil?
      @user.destroy
    end
    redirect_to admin_users_path
  end

  def update_individual
    unless params[:commit].blank?
      case params[:commit]
        when 'block' then
          block(params[:user_ids])
          redirect_to admin_users_path
        when 'release' then
          release(params[:user_ids])
          redirect_to admin_users_path
        else
          redirect_to admin_users_path
      end
    else
      redirect_to admin_users_path
    end
  end

  private
  def block(ids)
    users = User.find(ids)
    users.each do |user|
      unless user == current_user
        user.block!
      end
    end
  end

  def release(ids)
    users = User.find(ids)
    users.each do |user|
      unless user == current_user
        user.release!
      end
    end
  end

end