# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  tag_name   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tag_topics_on_tag_name  (tag_name) UNIQUE
#
class TagTopic < ApplicationRecord
    validates :tag_name, presence: true, uniqueness: true

    has_many :taggings,
        class_name: :Tagging,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        dependent: :destroy

    has_many :shortened_urls,
        through: :taggings,
        source: :shortened_url

    def popular_links
        shortened_urls.joins(:visits)
            .group(:long_url, :short_url)
            .order('COUNT(*) DESC')
            .select('long_url, short_url, COUNT(*) AS num_visits')
            .limit(5)
    end
end
