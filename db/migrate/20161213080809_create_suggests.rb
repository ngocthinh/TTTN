class CreateSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :suggests do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :suggests, [:user_id, :product_id, :created_at]
  end
end
