class CreateInitialTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true


    create_table :polls do |t|
      t.string :title, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :polls, :user_id
    add_foreign_key :polls, :users


    create_table :questions do |t|
      t.text :poll_text, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end

    add_index :questions, :poll_id
    add_foreign_key :questions, :polls


    create_table :answer_choices do |t|
      t.string :choice_text, null: false
      t.integer :question_id, null: false

      t.timestamps
    end

    add_index :answer_choices, :question_id
    add_foreign_key :answer_choices, :questions


    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end

    add_index :responses, [:user_id, :answer_choice_id], unique: true
    add_index :responses, :answer_choice_id #since answer_choice_id isn't first col above
    add_foreign_key :responses, :users
    add_foreign_key :responses, :answer_choices
  end
end
