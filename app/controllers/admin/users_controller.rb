class Admin::UsersController < AdminController

  def index
    @users = User.all.page(params[:page])
    if params[:name].present?
      @users = @users.user_search(params[:name])
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end

end
