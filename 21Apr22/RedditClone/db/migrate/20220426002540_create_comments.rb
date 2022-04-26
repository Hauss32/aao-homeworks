class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.integer :post_id, null: false, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
