class Public::RelationshipsController < PublicController
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
    @users = @user.following_users.page(params[:page])
  end

  def followed
    @user = User.find(params[:user_id])
    @users = @user.followed_users.page(params[:page])
  end
end
