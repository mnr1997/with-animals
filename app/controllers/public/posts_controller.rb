class Public::PostsController < PublicController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
    @animals = current_user.animals
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      @animals = current_user.animals
      render :new
    end
  end

  def index
    @posts = Post.all.preload(:favorites).page(params[:page])
    if params[:caption].present?
      @posts = @posts.caption_search(params[:caption])
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @animals = current_user.animals
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      @animals = current_user.animals
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, animal_ids: [])
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
