# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :polls,
        class_name: :Poll,
        primary_key: :id,
        foreign_key: :user_id,
        dependent: :destroy

    has_many :responses,
        class_name: :Response,
        primary_key: :id,
        foreign_key: :user_id

    def completed_polls #one or more responses to all questions in poll
        self.polls
            .joins(questions: :responses)
            .group("polls.id")
            .having("COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id)")
            .pluck(:title)
    end

    def incomplete_polls #partial or no responses to poll questions
        self.polls
            .left_outer_joins(questions: :responses)
            .group("polls.id")
            .having("COUNT(DISTINCT questions.id) > COUNT(DISTINCT responses.id)")
            .pluck(:title)
    end
    
end
