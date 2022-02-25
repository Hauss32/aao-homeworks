# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
    'Artlouvre5000',
    'ArtThief911',
    'BoudoirFan69'
]

users.map! { |name| User.create(username: name) }

artwork_titles = [
    'Bold-and-Brash',
    'Post-Modern-Eclectic',
    'Million-Dollar-Bay-Bee',
    'Midas-Touch', 
    'Girl-With-The-Off-White-Earring',
    'Moony-Night'
]

artworks = []

#2 artworks per artist
users.each do |user|
    id = user.id

    2.times do
        title = artwork_titles.shift
        url = "/app/assets/images/#{id}_#{title}"
        artworks << Artwork.create(title: title, artist_id: id, image_url: url)
    end
end

user_ids = users.map(&:id)

artworks.each do |art|
    artist_id = art.artist_id
    other_users = user_ids.dup
    other_users.delete(artist_id) #don't share with artwork's owner

    ArtworkShare.create(viewer_id: other_users.sample, artwork_id: art.id)
end


