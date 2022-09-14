# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do

    author = Author.create(name: Faker::Name.name, email: Faker::Internet.email)
 
 
    3.times do
 
      book = author.books.create(name: Faker::Lorem.sentence(word_count:2), description: Faker::Lorem.paragraph(sentence_count:2))
 
 
     2.times do
 
        book.chapters.create(name: Faker::Lorem.sentence(word_count: 2), short_description: Faker::Lorem.paragraph(sentence_count: 2))
 
     end
 
 
   end
 
 end