class Admin::DashboardsController < AdminController
  def index
    @users = User.page(params[:page])
  end
end
