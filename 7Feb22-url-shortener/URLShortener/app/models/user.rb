# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  premium    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true

    has_many :visits,
        class_name: :Visit,
        primary_key: :id,
        foreign_key: :user_id

    has_many :visited_urls,
        through: :visits,
        source: :shortened_url

    has_many :shortened_urls,
        class_name: :ShortenedURL,
        primary_key: :id,
        foreign_key: :user_id
end
