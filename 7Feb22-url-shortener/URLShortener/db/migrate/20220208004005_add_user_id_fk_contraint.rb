class AddUserIdFkContraint < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :shortened_urls, :users
  end
end
