# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_shortened_urls_on_long_url   (long_url)
#  index_shortened_urls_on_short_url  (short_url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ShortenedURL < ApplicationRecord
    validates :long_url, :short_url, null: false, uniqueness: true
    validate :no_spamming, :nopremium_max
    
    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    has_many :visits,
        class_name: :Visit,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        dependent: :destroy

    has_many :visitors,
        -> { distinct },
        through: :visits,
        source: :user

    has_many :taggings,
        class_name: :Tagging,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        dependent: :destroy

    has_many :tag_topics,
        through: :taggings,
        source: :tag_topic

    def self.make_short_url(user, long_url)
        options = {
            user_id: user.id,
            long_url: long_url,
            short_url: ShortenedURL.random_code
        }

        ShortenedURL.create!(options)
    end

    def self.random_code
        code = SecureRandom::urlsafe_base64(16)

        while ShortenedURL.exists?(short_url: code)
            code = SecureRandom::urlsafe_base64(16)
        end

        code
    end

    def self.prune(n)
        stale_urls = ShortenedURL.joins(:user)
            .joins(<<-SQL)
            LEFT OUTER JOIN (
                SELECT
                    shortened_url_id AS short_id,
                    MAX(created_at) AS last_visit
                FROM visits
                GROUP BY 1
            ) AS last_visits
            ON shortened_urls.id = last_visits.short_id
            SQL
            .where("last_visit < '#{n.minutes.ago}' OR 
                (last_visit IS NULL AND shortened_urls.created_at < '#{n.minutes.ago}')")
            .where('users.premium = false')
            .destroy_all
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent_uniques
        visits.select(:user_id)
            .where('created_at >= ?', 10.minutes.ago)
            .distinct
            .count
    end

    def no_spamming
        count_recents = ShortenedURL.where('created_at >= ? AND user_id = ?', 
                1.minute.ago, user_id)
            .count
        if count_recents >= 5
            errors[:user_id] << 'has already submitted 5 urls in the last minute'
        end
    end

    def nopremium_max
        user = User.find_by_id(user_id)
        return if user.premium

        count_urls = ShortenedURL.where(user_id: user_id).count

        if count_urls > 5
            errors[:user_id] << 'must be a premium member to store more than 5 URLs'
        end

    end
end
