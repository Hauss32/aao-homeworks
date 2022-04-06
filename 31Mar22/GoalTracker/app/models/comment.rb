class Comment < ApplicationRecord
    validate :body, :commentable_id, :commentable_type, presence: true
    validate :commentable_id, uniqueness: { scope: :commentable_type }

    belongs_to :author,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :commentable, polymorphic: true
end
