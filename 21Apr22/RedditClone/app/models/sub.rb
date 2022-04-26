class Sub < ApplicationRecord
    validates :title, :description, :user_id, presence: true
    validates :title, uniqueness: true

    belongs_to :moderator,
        class_name: :User,
        foreign_key: :user_id

    has_many :sub_posts
        
    has_many :posts,
        through: :sub_posts
end
