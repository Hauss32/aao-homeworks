class Comment < ApplicationRecord
    validates :body, :user_id, :commentable_id, :commentable_type, presence: true
    validates :commentable_id, uniqueness: { scope: :commentable_type }

    has_one :author,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :commentable, polymorphic: true
end
