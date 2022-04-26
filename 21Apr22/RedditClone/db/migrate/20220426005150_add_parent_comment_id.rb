class AddParentCommentId < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :parent_comment_id, :integer, index: true
    add_foreign_key :comments, :comments, column: :parent_comment_id
  end
end
