class Public::RanksController < ApplicationController
  def rank
    @posts = Post.joins(:favorites).group('posts.id').order('COUNT(favorites.id) DESC').page(params[:page])
  end
end
