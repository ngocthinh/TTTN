class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.boolean :isStatic
      t.integer :totalprice
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :carts, [:user_id, :created_at]
  end
end
