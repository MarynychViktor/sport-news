module Home
  class Article < ApplicationRecord
    belongs_to :article, class_name: '::Article'
    validates :article_id, :category_id, presence: true
    attr_writer :category_id, :subcategory_id, :team_id
    validates_inclusion_of :show, in: [true, false]

    default_scope { includes(article: %i[category subcategory team]).order(:created_at) }
    # default_scope { includes(article: %i[category subcategory team]) }

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
