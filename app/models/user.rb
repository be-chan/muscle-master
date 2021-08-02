class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :memos
  has_many :tweets
  has_many :likes
  has_many :comments

  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合６文字以上で入力してください' }, on: :create
  validates :password_confirmation, format: { with: VALID_PASSWORD_REGEX }, on: :create

  validates :nickname, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 1000 }

  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
