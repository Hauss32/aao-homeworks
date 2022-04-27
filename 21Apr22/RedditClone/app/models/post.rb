class Post < ApplicationRecord
    validates :title, presence: true
    validate :has_sub_relation

    belongs_to :author,
        class_name: :User,
        foreign_key: :user_id

    has_many :sub_posts

    has_many :subs,
        through: :sub_posts

    has_many :comments

    def comments_by_parent_id
        comments_hash = Hash.new { |h, k| h[k] = Array.new }
        comments = self.comments
                    .joins(:author)
                    .select('comments.*, users.email')
        comments.each { |c| comments_hash[c.parent_comment_id] << c }

        comments_hash
    end

    private
    def has_sub_relation
        unless self.subs.size > 0
            errors.add :Post, 'must belong to at least 1 Sub.'
        end
    end
end
