# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all()
Idea.destroy_all()
Review.destroy_all()
Like.destroy_all()
PASSWORD = "123"
test_user = User.create(
  first_name: "Stas",
  last_name: "Anikin",
  email: "stas@stas.com",
  password: PASSWORD,
)
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@gmail.com",
    password: PASSWORD,
  )
end
users = User.all
50.times do
  i = Idea.create(
    title: Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph,
    user: users.sample,
  )
  if i.valid?
    i.reviews = rand(1..10).times.map do
      Review.new(
        body: Faker::Hipster.paragraph,
        user: users.sample,
      )
    end
  end
end
ideas = Idea.all
ideas.each do |idea|
  idea.likers = users.shuffle.slice(0, rand(users.count))
end

reviews = Review.all
likes = Like.all
puts "generated #{users.count} users, #{ideas.count} ideas, #{reviews.count} reviews and #{likes.count} likes"
