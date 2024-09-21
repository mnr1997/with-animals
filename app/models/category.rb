class Category < ApplicationRecord
  has_many :animals
  has_many :category_posts, through: :animals, source: :posts

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 20 }
  
  scope :name_search, -> (name) do
    where("name LIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(name)}%")
  end
end
