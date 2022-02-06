class AddColumnsToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :created_at, :datetime, null:false
    add_column :houses, :updated_at, :datetime, null:false
    add_column :houses, :address, :text, null:false
  end
end
