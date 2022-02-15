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
    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :answer_choice
        class_name: :AnswerChoice,
        primary_key: :id,
        foreign_key: :answer_choice_id
end
