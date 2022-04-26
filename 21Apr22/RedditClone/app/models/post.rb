class Post < ApplicationRecord
    validates :title, presence: true
    validate :has_sub_relation

    belongs_to :author,
        class_name: :User,
        foreign_key: :user_id

    has_many :sub_posts

    has_many :subs,
        through: :sub_posts

    private
    def has_sub_relation
        unless self.subs.size > 0
            errors.add :Post, 'must belong to at least 1 Sub.'
        end
    end
end
