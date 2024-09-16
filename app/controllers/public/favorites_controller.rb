class Public::FavoritesController < PublicController

  def create
    favorite = current_user.favorites.new(post_id: params[:post_id])
    favorite.save!
    @post = Post.find(params[:post_id])
    render :toggle
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy!
    @post = Post.find(params[:post_id])
    render :toggle
  end

  def index
    @posts = current_user.favorite_posts.page(params[:page])
  end

end
