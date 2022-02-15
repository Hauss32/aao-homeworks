class FixQuestionTextCol < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :poll_text, :question_text
  end
end
