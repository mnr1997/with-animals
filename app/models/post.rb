class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :animal_posts, dependent: :destroy
  has_many :animals, through: :animal_posts, source: :animal

  has_one_attached :image

  validates :image, presence: true
  validates :caption, presence: true, length: { maximum: 200 }

  scope :caption_search, -> (caption) do
    where("caption LIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(caption)}%")
  end

  def get_image(width, height)
    if image.blob.variable?
      image.variant(resize_to_fit: [width, height]).processed
    else
      image
    end
  end

  def favorited_by?(user)
    favorites.any? { |fav| fav.user_id == user.id }
  end
end
