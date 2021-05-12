FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.name }
    hidden { false }
    static { false }
  end
end
