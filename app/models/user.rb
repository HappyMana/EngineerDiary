class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, through: :likes
  has_one_attached :user_img
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :password, presence: true, on: :create

  def already_liked(post_id, user_id)
    is_like = Like.where(post_id: post_id, user_id: user_id).exists?
  end
end
