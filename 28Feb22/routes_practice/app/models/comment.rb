class Comment < ApplicationRecord
    validates :artwork_id, :author_id, :body, presence: true

    belongs_to :artwork

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id
end