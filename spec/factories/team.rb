FactoryBot.define do
  factory :team do
    name { Faker::Name.unique.name }
    hidden { false }
    subcategory
  end
end
