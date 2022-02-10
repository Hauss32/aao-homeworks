class RemoveLongUrlIndexUnique < ActiveRecord::Migration[5.2]
  def change
    remove_index :shortened_urls, :long_url #currently enforces uniques
    add_index :shortened_urls, :long_url #regular index
  end
end
