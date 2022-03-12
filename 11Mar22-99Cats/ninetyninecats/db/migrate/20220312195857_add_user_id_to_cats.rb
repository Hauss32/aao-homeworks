class AddUserIdToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :user_id, :integer, null: false, default: 3
    add_foreign_key :cats, :users
  end
end
