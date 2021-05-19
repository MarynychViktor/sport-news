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
