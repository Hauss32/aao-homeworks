class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :url
      t.text :body
      t.integer :sub_id, null: false, foreign_key: true, index: true
      t.integer :user_id, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
