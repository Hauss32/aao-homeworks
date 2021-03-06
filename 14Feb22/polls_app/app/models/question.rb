# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  question_text :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_id       :integer          not null
#
# Indexes
#
#  index_questions_on_poll_id  (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (poll_id => polls.id)
#
class Question < ApplicationRecord
    validates :question_text, presence: true

    belongs_to :poll,
        class_name: :Poll,
        primary_key: :id,
        foreign_key: :poll_id
    
    has_many :answer_choices,
        class_name: :AnswerChoice,
        primary_key: :id, 
        foreign_key: :question_id,
        dependent: :destroy

    has_many :responses,
        through: :answer_choices,
        source: :responses

    def results
        rows = self.answer_choices
            .select("answer_choices.choice_text AS text, COUNT(responses.id) AS count_answers")
            .left_outer_joins(:responses)
            .where(question_id: id)
            .group("1")

        rows.each_with_object({}) { |row, hash| hash[row.text] = row.count_answers }
    end
end
