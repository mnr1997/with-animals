class Admin::DashboardsController < AdminController
  def index
    @users = User.all
  end
end
