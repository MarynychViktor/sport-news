# TODO: remove
module Seeder
  class DatabaseSeeder
    def self.seed
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

      categories.each do |c|
        category = Category.create!(name: c[:category])
        c[:subcategories].each do |s|
          subcategory = category.subcategories.create!(name: s[:name])
          s[:teams].each do |team|
            subcategory.teams.create!(name: team[:name])
          end
        end
      end
    end
  end
end