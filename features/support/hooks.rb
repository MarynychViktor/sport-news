require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

After do |scenario, block|
  DatabaseCleaner.clean
end

Before('@ia') do
  Random.rand(1..3).times do
    create(:category) do |category|
      Random.rand(1..3).times do
        create(:subcategory, category: category) do |subcategory|
          Random.rand(1..3).times do
            create(:team, subcategory: subcategory)
          end
        end
      end
    end
  end
end