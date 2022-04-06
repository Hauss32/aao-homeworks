class Goal < ApplicationRecord
    include Commentable

    validates :title, :description, presence: true

    belongs_to :user
end
