class Cart < ApplicationRecord
  belongs_to :user
  
  has_many :cart_items, dependent: :destroy
  

  def group_by_criteria
    created_at.to_date.to_s(:db)
  end
  
end
