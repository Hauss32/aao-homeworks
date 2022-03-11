# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cat_names = [
    'Mittens', 
    'Chairman Meow', 
    'Rascal', 
    'Snowball', 
    'Kitty McCatface'
]

dates = [
    '2022-01-01',
    '2021-10-15',
    '2021-07-04',
    '2020-02-28',
    '2018-12-25'
]

descriptions = [
    'Cute cat, but mean as heck.',
    'A (mostly) hairless cat with cat allergies.',
    'Speaks 4 dialects of catonese.',
    'Likes to give dead mice as gifts. DO NOT REFUSE THEM!',
    'This cat was a dog in a past life.'
]

cat_names.each do |name|
    Cat.create(name: name, birth_date: dates.pop, color: Cat::COLORS.sample, 
        sex: ['M', 'F'].sample, description: descriptions.pop)
end