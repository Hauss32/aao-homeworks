# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Response.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
Poll.destroy_all
User.destroy_all


User.create!(username: 'NormalChris')
User.create!(username: 'EvilChris')

Poll.create!(title: 'Best Users', user_id: User.first.id)

Question.create!(question_text: 'Which User do you like better?', poll_id: Poll.first.id)

AnswerChoice.create!(choice_text: 'NormalChris', question_id: Question.first.id)
AnswerChoice.create!(choice_text: 'EvilChris', question_id: Question.first.id)

Response.create!(answer_choice_id: AnswerChoice.last.id, user_id: User.last.id)



