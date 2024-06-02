class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end
  
  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
    if @favorites.present?
      @posts = @favorites.map {|favorite| favorite.post }
    else
      @posts = []
    end
  end
end
