class Post < ApplicationRecord
  has_many :likes
  belongs_to :user
  belongs_to :tag
  has_many :users, through: :likes

end
