class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :count_user, ->id do  
  select("rates.*, count(user_id) AS count").
      where("product_id = ?", id)
  end
end
