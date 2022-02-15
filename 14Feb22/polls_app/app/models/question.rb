# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_text  :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :integer          not null
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
    belongs_to :poll,
        class_name: :Poll,
        primary_key: :id,
        foreign_key: :poll_id
    
    has_many :answer_choices,
        class_name: :AnswerChoice,
        primary_key: :id, 
        foreign_key: :question_id
end
