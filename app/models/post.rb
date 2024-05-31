class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :animal_posts, dependent: :destroy
  has_many :animals, through: :animal_posts, source: :animal

  validates :image, presence: true
  validates :caption, presence: true

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
