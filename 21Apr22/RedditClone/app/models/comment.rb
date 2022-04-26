class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :author,
        class_name: :User,
        foreign_key: :user_id

    belongs_to :post

    belongs_to :comment, 
        optional: true,
        foreign_key: :parent_comment_id

    has_many :child_comments,
        class_name: :Comment,
        foreign_key: :parent_comment_id
end
