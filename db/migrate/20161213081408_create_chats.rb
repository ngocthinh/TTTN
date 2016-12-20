class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :chats, [:user_id, :created_at]
  end
end
