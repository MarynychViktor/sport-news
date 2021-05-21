# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

['Lifestyle', 'Dealbook', 'Video', 'Team hub'].each do |name|
  Category.create!(name: name, static: true)
end

# TODO: refactor and remove after testing
categories = [
  {
    category: 'NBA',
    subcategories: [
      {
        name: 'AFC East ',
        teams: [
          { name: 'Houston' },
          { name: 'Indianapolis' },
          { name: 'Jacksonville' },
          { name: 'Tennessee' }
        ]
      },
      {
        name: 'AFC South',
        teams: [
          { name: 'Colorado' },
          { name: 'New York' },
          { name: 'Chicago' }
        ]
      },
      {
        name: 'AFC North',
        teams: [
          { name: 'New Jersey' },
          { name: 'San Jose' },
          { name: 'Vancover' }
        ]
      }
    ]
  },
  {
    category: 'Football',
    subcategories: [
      {
        name: 'Premier League',
        teams: [
          { name: 'Manchester United' },
          { name: 'Manchester City' },
          { name: 'Tottenham' },
          { name: 'Liverpool' }
        ]
      },
      {
        name: 'LA League',
        teams: [
          { name: 'Real MD' },
          { name: 'Sevilia' },
          { name: 'Barcelona' },
          { name: 'Benficca' }
        ]
      },
      {
        name: 'Italian League',
        teams: [
          { name: 'Inter' },
          { name: 'Juventus' },
          { name: 'Milan' },
          { name: 'Napoli' },
          { name: 'Lazio' }
        ]
      }
    ]
  }
]

categories.each do |category_descriptor|
  category = Category.create!(name: category_descriptor[:category])
  category_descriptor[:subcategories].each do |subcategory_descriptor|
    subcategory = category.subcategories.create!(name: subcategory_descriptor[:name])

    subcategory_descriptor[:teams].each do |team_descriptor|
      team = subcategory.teams.create!(name: team_descriptor[:name])
      2.times do
        FactoryBot.create(:article, category: category, subcategory: subcategory, team: team,
                                    published_at: DateTime.current)
      end
    end
  end
end


User.create!(
  first_name: 'Admin',
  last_name: 'Admin',
  email: 'sportnews@mail.com',
  password: 'secret123',
  confirmed_at: Date.new,
  remote_photo_url: 'https://us.123rf.com/450wm/vovikmar/vovikmar1505/vovikmar150500085/40674362-beautiful-landscape-in-the-mountains-at-sunshine-.jpg?ver=6'
).add_role :admin
