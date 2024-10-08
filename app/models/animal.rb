class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :animal_posts, dependent: :destroy
  has_many :posts, through: :animal_posts, source: :post
  
  has_one_attached :animal_image

  enum sex: { male: 0, female: 1, unknown: 2 }

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }

  def get_animal_image(width, height)
    unless animal_image.attached?
      file_path = Rails.root.join("app/assets/images/paw.png")
      animal_image.attach(io: File.open(file_path), filename: "default-image.png", content_type: "imege/png")
    end
    animal_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
