class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to user_path(user)
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to user_path(user)
  end
  
  def following
    @user = User.find(params[:user_id])
    @users = @user.following_users
  end
  
  def followed
    @user = User.find(params[:user_id])
    @users = @user.followed_users
  end
  
  private
  
  def relationship_params
    params.require(:relationship).permit(:following_user_id, :followed_user_id)
  end
end
