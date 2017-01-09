class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
 
  def index
    @users = User.paginate page: params[:page], per_page: Settings.user_per_page 
  end

  def show
    @user = User.find_by id: params[:id]
    return render file: Settings.page_404_url unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end
  def edit 
     
  end
  
  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t "user_deleted"
    redirect_to users_url
  end
  
  private

  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_log_in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end

end
