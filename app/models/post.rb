class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :user

  accepts_nested_attributes_for :tags, :reject_if => proc { |att| att[:name].blank?}
end
