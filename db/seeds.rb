# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Gender.create(value: 'Herr')
Gender.create(value: 'Frau')

# Dummy data
#
10.times do
  password = Forgery('basic').password
  User.create( first_name: Forgery('name').first_name,
               last_name: Forgery('name').last_name,
               gender: Gender.all.sample,
               email: Forgery('email').address,
               password: password,
               password_confirmation: password
  )
end

require 'open-uri'
User.all.each do |user|
  (0..2).to_a.sample.times do
    user.posts.create( title: Forgery(:lorem_ipsum).words((1..6).to_a.sample.to_i),
                       abstract: Forgery('lorem_ipsum').words((1..20).to_a.sample.to_i),
                       content: open("http://jaspervdj.be/lorem-markdownum/markdown.txt?no-code=on&no-quotes=on").read
                       )
  end
end
