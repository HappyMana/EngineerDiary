class Post < ApplicationRecord
  has_many :goods
  has_many :comments
  belong_to :user
  has_many :users, through: :comments
  has_many :users, through: :goods
end
w
