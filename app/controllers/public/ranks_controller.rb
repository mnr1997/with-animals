class Public::RanksController < ApplicationController
  def index
    @posts = Post.joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC').page(params[:page])
  end
end
