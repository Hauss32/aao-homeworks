class AddUserActivation < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_code, :string
    add_column :users, :is_activated, :boolean, null: false, default: false

    add_index :users, :activation_code
  end
end
