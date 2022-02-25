class Artwork < ApplicationRecord
    validates :image_url, presence: true
    validates :title, presence: true, uniqueness: { scope: :artist_id }

    belongs_to :artist,
        class_name: :User,
        primary_key: :id,
        foreign_key: :artist_id

    has_many :artwork_shares

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer
end