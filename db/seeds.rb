# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Lifestyle', 'Dealbook', 'Video', 'Team hub'].each do |name|
  Category.create!(name: name, static: true)
end

if "development" == ENV['RAILS_ENV']
  User.create!(
    first_name: 'Admin',
    last_name: 'Admin',
    email: 'sportnews@mail.com',
    password: 'secret123',
    confirmed_at: Date.new,
    remote_photo_url: 'https://us.123rf.com/450wm/vovikmar/vovikmar1505/vovikmar150500085/40674362-beautiful-landscape-in-the-mountains-at-sunshine-.jpg?ver=6'
  ).add_role :admin
end
