class CreateRentalRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_requests do |t|
      t.integer :cat_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false, default: 'PENDING'
      
      t.timestamps
    end

    add_index :rental_requests, :cat_id
    add_foreign_key :rental_requests, :cats
  end
end
