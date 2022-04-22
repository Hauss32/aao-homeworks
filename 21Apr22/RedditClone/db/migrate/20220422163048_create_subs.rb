class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.integer :user_id, null: false, index: true
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
    add_foreign_key :subs, :users
  end
end
