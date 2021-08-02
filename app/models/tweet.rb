class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :memo 
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true, length: { maximum: 150 }

  def liked_by(user)
    Like.find_by(user_id: user.id, tweet_id: id)
  end
end
