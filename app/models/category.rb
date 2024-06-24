class Category < ApplicationRecord
  has_many :animals
  has_many :category_posts, through: :animals, source: :posts
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 20 }
end
