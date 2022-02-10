class CreateTagTopicsAndTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :tag_name, null: false

      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps
    end

    add_index :taggings, [:tag_topic_id, :shortened_url_id], unique: true
    add_index :tag_topics, :tag_name, unique: true
  end
end
