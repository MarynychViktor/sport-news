# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  hidden     :boolean          default(FALSE)
#  name       :string           not null
#  row_order  :integer
#  static     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.name }
    hidden { false }
    static { false }
  end
end
