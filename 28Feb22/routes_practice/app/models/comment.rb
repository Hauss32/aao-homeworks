class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :artwork

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id

    has_many :likes, as: :likeable
end