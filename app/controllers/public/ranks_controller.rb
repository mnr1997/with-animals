class Public::RanksController < ApplicationController
  def index
    @posts = Post.order(favorites_count: :desc, id: :desc)
                 .preload(:favorites, :user)
                 .page(params[:page])
  end
end
