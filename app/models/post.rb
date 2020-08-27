class Post < ApplicationRecord
  validates :tweet, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
end
