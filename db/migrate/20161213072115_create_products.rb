class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.text :productname
      t.integer :productPrice
      t.boolean :productStatus
      t.text :productDescription
      t.integer :rate
      t.string :upPicture
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, [:category_id, :created_at]
  end
end
