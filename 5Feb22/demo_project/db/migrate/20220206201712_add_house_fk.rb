class AddHouseFk < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :house_id, :integer, index:true
    add_foreign_key :people, :houses
  end
end
