class AddUniquesToUser < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :username, unique: true
    remove_index :users, :session_token
    add_index :users, :session_token, unique: true
  end
end
