class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  has_one_attached :animal_image
  
  def get_animal_image(width, height)
    
  end
end
