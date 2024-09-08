class Public::RanksController < ApplicationController
  def index
    @posts = Post.order(favorites_count: :desc, id: :asc).page(params[:page])
  end
end
