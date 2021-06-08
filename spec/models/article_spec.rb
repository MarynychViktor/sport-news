# == Schema Information
#
# Table name: articles
#
#  id               :bigint           not null, primary key
#  alt              :string
#  caption          :string
#  content          :text
#  display_comments :boolean          default(TRUE), not null
#  headline         :string
#  location         :string
#  picture          :string           not null
#  published_at     :datetime
#  slug             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint           not null
#  subcategory_id   :bigint
#  team_id          :bigint
#
# Indexes
#
#  index_articles_on_category_id     (category_id)
#  index_articles_on_slug            (slug) UNIQUE
#  index_articles_on_subcategory_id  (subcategory_id)
#  index_articles_on_team_id         (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (subcategory_id => subcategories.id)
#  fk_rails_...  (team_id => teams.id)
#
require 'rails_helper'

