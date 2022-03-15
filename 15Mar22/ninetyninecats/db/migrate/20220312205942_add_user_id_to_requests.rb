class AddUserIdToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :rental_requests, :user_id, :integer, null: false, default: 2
    add_foreign_key :rental_requests, :users  
    add_index :rental_requests, :user_id

    add_index :cats, :user_id
  end
end
