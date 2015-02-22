require './database.rb'

require 'faker'

User.destroy
Blog.destroy

users = [
  user_1 = User.create(username: Faker::Internet.user_name, password: 'apples'),
  user_2 = User.create(username: Faker::Internet.user_name, password: 'apples'),
  user_3 = User.create(username: Faker::Internet.user_name, password: 'apples')
]

10.times do
  blog = Blog.create(
                    title: Faker::Lorem.words(6).join(' '),
                    content: Faker::Lorem.paragraph(rand(10)),
                    created_at: DateTime.now,
                    author: users.sample
                    )
  blog.author = user_1
  puts blog.valid?
  blog.save
end
