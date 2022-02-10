# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_visits_on_shortened_url_id  (shortened_url_id)
#  index_visits_on_user_id           (user_id)
#
class Visit < ApplicationRecord
    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id
        
    belongs_to :shortened_url,
        class_name: :ShortenedURL,
        primary_key: :id,
        foreign_key: :shortened_url_id

    def self.record_visit!(user, shortened_url)
        short_record = ShortenedURL.find_by(short_url: shortened_url)
        raise "Short URL '#{shortened_url}' does not exist." unless short_record

        options = {
            user_id: user.id,
            shortened_url_id: short_record.id
        }

        Visit.create!(options)
    end
end
