class CreateProductVieweds < ActiveRecord::Migration[5.0]
  def change
    create_table :product_vieweds do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :product_vieweds, [:user_id, :product_id, :created_at]
  end
end
