# == Schema Information
#
# Table name: subcategories
#
#  id          :bigint           not null, primary key
#  hidden      :boolean          default(FALSE)
#  name        :string           not null
#  row_order   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_subcategories_on_category_id           (category_id)
#  index_subcategories_on_name_and_category_id  (name,category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :subcategory do
    name { Faker::Name.unique.name }
    hidden { false }
    category
  end
end
