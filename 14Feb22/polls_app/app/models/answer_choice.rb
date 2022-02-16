# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  choice_text :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_answer_choices_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class AnswerChoice < ApplicationRecord
    validates :choice_text, presence: true

    belongs_to :question,
        class_name: :Question,
        primary_key: :id,
        foreign_key: :question_id

    has_many :responses,
        class_name: :Response,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        dependent: :destroy
end
