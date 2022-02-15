# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_responses_on_answer_choice_id              (answer_choice_id)
#  index_responses_on_user_id_and_answer_choice_id  (user_id,answer_choice_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (answer_choice_id => answer_choices.id)
#  fk_rails_...  (user_id => users.id)
#
class Response < ApplicationRecord
    validate :user_already_answered?

    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :answer_choice,
        class_name: :AnswerChoice,
        primary_key: :id,
        foreign_key: :answer_choice_id

    has_one :question,
        through: :answer_choice,
        source: :question

    def sibling_responses
        self.question.responses.where.not(id: id)
    end

    def user_already_answered?
        if sibling_responses.exists?(user_id: user_id)
            errors[:user] << "has already answered this question"
        end
    end
end
