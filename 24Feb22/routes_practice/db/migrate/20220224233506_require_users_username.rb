class RequireUsersUsername < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :username, 'default'
  end
end
