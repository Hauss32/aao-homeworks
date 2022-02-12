class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    albums = self
      .albums
      .select('albums.title, COUNT(*) AS count_tracks')
      .joins(:tracks)
      .group('albums.title')

    tracks_count = {}

    albums.each { |album| tracks_count[album.title] = album.tracks.length }

    tracks_count = {}
  end
end
