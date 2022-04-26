class CreateSubPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_posts do |t|
      t.integer :sub_id, null: false, foreign_key: true
      t.integer :post_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :sub_posts, [:post_id, :sub_id], unique: true
  end
end
