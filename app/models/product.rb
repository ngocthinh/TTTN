class Product < ApplicationRecord
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :product_vieweds, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  validates :category_id, presence: true
end
