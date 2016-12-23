class Product < ApplicationRecord
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :product_vieweds, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  mount_uploader :upPicture, PictureUploader

  validates :category_id, presence: true
  validates :productPrice, presence: true, numericality: { only_integer: true }	

  scope :search_product, ->search do   
    where "productname LIKE ?","%#{search}%" if search.present?
  end
end
