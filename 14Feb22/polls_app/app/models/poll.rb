# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_polls_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Poll < ApplicationRecord
    validates :title, presence: true

    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    has_many :questions,
        class_name: :Question,
        primary_key: :id,
        foreign_key: :poll_id
    
end
