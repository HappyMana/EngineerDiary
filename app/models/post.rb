class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :tag
  has_many :liked_users, through: :likes

end
