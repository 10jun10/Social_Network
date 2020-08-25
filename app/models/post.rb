class Post < ApplicationRecord
  validates :tweet, presence: true
end
