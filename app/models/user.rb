class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, through: :comments
  has_many :posts, through: :goods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
