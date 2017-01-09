class User < ApplicationRecord
  before_save {email.downcase!}

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :product_vieweds, dependent: :destroy
  has_one  :carts, dependent: :destroy
  
  validates :name,  presence: {message: "enter name please"}, length: {maximum: Settings.maximum_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.maximum_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.minimum_password}

  def current_user? user
    self == user
  end

  scope :user_date, -> do
  select("users.*,").
    group("updated_at")
  end
end
