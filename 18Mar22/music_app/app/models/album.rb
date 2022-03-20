class Album < ApplicationRecord
    validate :title, :year, :is_live_album

    belongs_to :band
end