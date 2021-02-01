class Idea < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
