# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'someuser@musicapp.test', password: 'password', is_activated: true)

band = Band.create(name: 'The Rubber Band')

album = Album.create(
    title: 'Rubber Band Man', 
    year: 1969, 
    is_live_album: true,
    band_id: band.id)

tracks = [
    'Captain Elastic', 
    'Slingshot Hotshot', 
    'Stretch for the Moon',
    'Snappy',
    'Stretch it!']

tracks.each_with_index do |track, idx|
    Track.create(
        title: track,
        ord: idx+1,
        lyrics: '',
        album_id: album.id)
end

Track.last.update(is_bonus_track: true)