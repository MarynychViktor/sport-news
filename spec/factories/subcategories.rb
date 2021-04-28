FactoryBot.define do
  factory :subcategory do
    name { Faker::Name.unique.name }
    hidden { false }
    category
  end
end
