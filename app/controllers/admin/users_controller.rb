class Admin::UsersController < AdminController
  
  def index
    if params[:name].present?
      @users = User.where("name LIKE ?", "%#{params[:name]}%").page(params[:page])
      @users = User.page(params[:page]) if @users.empty?
    else
      @users = User.page(params[:page])
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: "ユーザーを削除しました。"
  end
  
end
