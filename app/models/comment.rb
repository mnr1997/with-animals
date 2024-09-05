class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  
  validates :comment, presence: true, length: { maximum: 50 }
end
