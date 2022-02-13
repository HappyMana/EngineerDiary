class Post < ApplicationRecord
  has_many :goods
  belong_to :user
  belong_to :tag
  has_many :users, through: :goods
end
w
