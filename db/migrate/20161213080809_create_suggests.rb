class CreateSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :suggests do |t|
      t.string :name
      t.string :content
      t.string :up_picture
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :suggests, [:user_id, :created_at]
  end
end
