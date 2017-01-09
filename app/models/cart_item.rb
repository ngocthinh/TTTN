class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  scope :cartitems, -> id do
  select("cart_items.*, sum(count) AS Scount, sum(price) AS Sprice").
      where("cart_id = ?", id).
      group("product_id")
  end

  scope :showcartitems, -> id do
  select("cart_items.*").
      where("cart_id = ?", id)
  end

  scope :cartitems_product, -> do
    select("cart_items.*, sum(count) AS count").
    group("product_id")
  end

  scope :cartorder, -> do
    select("cart_items.*, sum(count) AS count").
    group_by(&:group_by_criteria)
  end

  def group_by_criteria
    created_at.to_date.to_s(:db)
  end

end
