class Public::RanksController < ApplicationController
  def rank
    rank_post_ids = Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)
    @rank = Post.where(id: rank_post_ids).page(params[:page])
  end
end
