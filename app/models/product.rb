class Product < ApplicationRecord
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :product_vieweds, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  mount_uploader :upPicture, PictureUploader

  validates :category_id, presence: true
  #validates :productPrice, presence: true, numericality: {only_integer: true}
  default_scope -> {order(created_at: :desc)} 

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      product = find_by_id(row["productname"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      product.update(parameters.permit(:productname, :productPrice, :productStatus,:productDescription, :rate, :upPicture, :category_id))
      product.save!  
    
    end
  end

  scope :search_product, ->search do   
    where("productname LIKE ?","%#{search}%").order "productPrice" if search.present?
  end

  scope :hot_product, -> do
  where(productStatus: true).limit(4)
  end
  
 scope :product_create, -> do
  select("products.*,count(id) AS count").
  group_by(&:group_by_criteria)
  end

  def group_by_criteria
    created_at.to_date.to_s(:db)
  end
  
end
