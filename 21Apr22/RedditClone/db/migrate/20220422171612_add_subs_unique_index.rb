class AddSubsUniqueIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :subs, :title, unique: true
  end
end
