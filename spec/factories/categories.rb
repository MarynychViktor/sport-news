FactoryBot.define do
  #
  # factory :team do
  #   name { Faker::Name.unique.name }
  #   hidden { false }
  #   subcategory
  # end
  # factory :subcategory do
  #   name { Faker::Name.unique.name }
  #   hidden { false }
  #   category
  # end

  factory :category do
    name { Faker::Name.unique.name }
    hidden { false }
    static { false }
  end
end
