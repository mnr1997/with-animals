class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :image, presence: true
  validates :caption, presence: true
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/子猫.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image/jpg', content_type: 'imege/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
