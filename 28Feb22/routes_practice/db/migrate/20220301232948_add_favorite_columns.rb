class AddFavoriteColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :favorite, :boolean
    add_column :artworks_shares, :favorite, :boolean
  end
end
