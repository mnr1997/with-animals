class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :animal_posts, dependent: :destroy
  has_many :posts, through: :animal_posts, source: :post
  
  enum sex: { male: 0, female: 1, unknown: 2 }
  
  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  has_one_attached :animal_image

  def get_animal_image(width, height)
    unless animal_image.attached?
      file_path = Rails.root.join('app/assets/images/肉球.jpeg')
      animal_image.attach(io: File.open(file_path), filename: 'default-image/jpg', content_type: 'imege/jpeg')
    end
    animal_image.variant(resize_to_limit: [width, height]).processed
  end
end
