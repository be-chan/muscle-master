class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  validates :follower_id, presence: true, uniqueness: { scope: :following_id }
  validates :following_id, presence: true
  validate :self_follow_valid
  def self_follow_valid
    if follower_id == following_id
      errors.add(:follower_id, 'が自分の場合はフォローできません')
    end
  end
end
