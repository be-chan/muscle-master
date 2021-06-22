class Memo < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :set_count

  with_options presence: true do
    validates :start_time
    validates :training_content, length: { maximum: 20, message: 'は20文字以内で入力してください' }
  end

  validates :weight, presence: true, format: { with: /\A[0-9]+\z/ }, numericality: { greater_than: 1, less_than: 1000, message: 'は半角数字で1~999以内で入力してください' }

  validates :training_time, presence: true, format: { with: /\A[0-9]+\z/}, numericality: { greater_than: 1, less_than: 101, message: 'は半角数字で1~100以内で入力してください' }
  
  validate :day_after_tomorrow
    def day_after_tomorrow
      return if start_time.blank?
      errors.add(:start_time, "は今日までのを選択してください") if start_time > Date.today
    end
end
