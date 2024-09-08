class Public::UsersController < PublicController
  def index
    @users = User.all
                 .order(created_at: :desc)
                 .page(params[:page])
    if params[:name].present?
      @users = @users.user_search(params[:name])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.preload(:favorites).page(params[:page])
  end
end
