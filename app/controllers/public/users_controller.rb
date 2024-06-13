class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def index
    if params[:name].present?
      @users = User.where("name LIKE ?", "%#{params[:name]}%")
      @users = User.page(params[:page]) if @users.empty?
    else
      @users = User.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def confirm
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
   def ensure_guest_user
     @user = User.find(params[:id])
     if @user.guest_user?
       redirect_to user_path(current_user)
     end
    end
end
