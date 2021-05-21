require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

After do |scenario, block|
  DatabaseCleaner.clean
end

Before('@articles') do
  create(:category, name: 'Football') do |category|
    create(:subcategory, category: category) do |subcategory|
      2.times do
        create(:team, subcategory: subcategory) do |team|
          3.times do
            create(:article, category: category, subcategory: subcategory, team: team)
          end
        end
      end
    end
  end
end
