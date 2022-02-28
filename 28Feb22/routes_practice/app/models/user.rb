class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        class_name: :Artwork,
        primary_key: :id,
        foreign_key: :artist_id,
        dependent: :destroy

    has_many :artwork_shares,
        primary_key: :id,
        foreign_key: :viewer_id,
        dependent: :destroy

    has_many :shared_artworks,
        through: :artwork_shares,
        source: :artwork

    has_many :comments,
        foreign_key: :author_id,
        dependent: :destroy
end