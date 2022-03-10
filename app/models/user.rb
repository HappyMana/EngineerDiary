class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, through: :likes
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def already_liked?(post_id)
    Like.where(post_id: post_id).exists?
  end
end
