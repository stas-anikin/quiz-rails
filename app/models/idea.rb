class Idea < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  before_save :capitalize_title

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  private

  def capitalize_title
    self.title.capitalize!
  end
end
