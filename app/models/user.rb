class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_user_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_user_id", dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :followed_user
  has_many :followed_users, through: :passive_relationships, source: :following_user

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image/jpg", content_type: "image/jpg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def follow(user)
    active_relationships.create(followed_user_id: user.id)
  end
  
  def unfollow(user)
    active_relationships.find_by(followed_user_id: user.id).destroy
  end
  
  def following?(user)
    following_users.include?(user)
  end

end
