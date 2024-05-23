class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def confirm
  end
  
  private
  
  def user_params
    params.repuire(:user).permit(:name, :profile_image)
  end
end
