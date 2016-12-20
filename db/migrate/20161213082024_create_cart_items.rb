class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :count
      t.integer :price
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :cart_items, [:cart_id, :created_at]
  end
end
