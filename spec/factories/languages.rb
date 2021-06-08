# == Schema Information
#
# Table name: languages
#
#  id          :bigint           not null, primary key
#  hidden      :boolean          default(FALSE)
#  locale      :string           not null
#  system      :boolean          default(FALSE)
#  translation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_languages_on_locale  (locale) UNIQUE
#
FactoryBot.define do
  factory :language do
    lang { "MyString" }
    translation { "" }
  end
end
