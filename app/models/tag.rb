class Tag < ApplicationRecord
  has_many :posts
  validates :tag_name, uniqueness: true
end
