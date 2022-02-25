class ArtworkShare < ApplicationRecord
    self.table_name = 'artworks_shares'
    validates :viewer_id, presence: true
    validates :artwork_id, presence: true, uniqueness: { scope: :viewer_id }

    belongs_to :viewer,
        class_name: :User,
        primary_key: :id,
        foreign_key: :viewer_id

    belongs_to :artwork
end