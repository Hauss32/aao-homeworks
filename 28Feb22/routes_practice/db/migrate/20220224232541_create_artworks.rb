class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.text :image_url, null: false
      t.integer :artist_id, null: false

      t.timestamps

    end
    
    add_foreign_key :artworks, :users, column: :artist_id
    add_index :artworks, [:title, :artist_id], unique: true
  end
end
