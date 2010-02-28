class Admin::UsersController < Admin::AdminController
  add_breadcrumb "users", "admin_users_path"
  add_breadcrumb "new user", "new_admin_user_path", :only => [:new, :create]
  add_breadcrumb "edit user", "edit_admin_user_path", :only => [:edit, :update]

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
      notify :notice, 'user was successfully created'
      redirect_to admin_user_path(@user)
    else
      render :action => "new"
    end
  end

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.find_by_login(params[:id])
    if @user.update_attributes(params[:user])
      notify :notice, 'user was successfully updated'
      redirect_to admin_user_path(@user)
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find_by_login(params[:id])
    unless @user.nil?
      @user.destroy
    end
    redirect_to admin_users_path
  end

  def update_individual        
    unless params[:user_ids].nil? || params[:operation].nil?
      params[:operation].keys.each do |o|
        self.send o.to_sym, params[:user_ids]
      end    
    end
    redirect_to admin_users_path
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