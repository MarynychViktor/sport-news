# == Schema Information
#
# Table name: home_articles
#
#  id         :bigint           not null, primary key
#  show       :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#
# Indexes
#
#  index_home_articles_on_article_id  (article_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
module Home
  class Article < ApplicationRecord
    belongs_to :article, class_name: '::Article'
    attr_writer :category_id, :subcategory_id, :team_id

    validates :article_id, presence: true
    validates_inclusion_of :show, in: [true, false]

    scope :with_article, -> { includes(article: %i[category subcategory team]) }
    scope :visible, -> { where(show: true) }

    def category_id
      article&.category_id
    end

    def subcategory_id
      article&.subcategory_id
    end

    def team_id
      article&.team_id
    end
  end
end
