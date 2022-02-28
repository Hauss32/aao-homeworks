class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :artwork_id, null: false
      t.integer :author_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :comments, :artwork_id
    add_index :comments, :author_id
    add_foreign_key :comments, :artworks
    add_foreign_key :comments, :users, column: :author_id 
  end
end
