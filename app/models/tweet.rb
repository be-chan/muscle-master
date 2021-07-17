class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :memo 

  validates :body, presence: true, length: { maximum: 150 }
end
