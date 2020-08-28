class Follow < ApplicationRecord
  belongs_to :user, optional: true
  validates :following_id, :followed_by_id, presence: true
end
