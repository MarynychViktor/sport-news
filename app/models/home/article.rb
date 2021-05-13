module Home
  class Article < ApplicationRecord
    belongs_to :article, class_name: '::Article'
    attr_writer :category_id, :subcategory_id, :team_id

    validates :article_id, presence: true
    validates_inclusion_of :show, in: [true, false]

    default_scope { includes(article: %i[category subcategory team]).order(:created_at) }

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

    def self.resolve
      articles = all.to_a
      articles << new if articles.empty?
      articles
    end

    def self.build_from(params)
      params.dup.map do |attributes|
        attributes[:show] ||= false
        article = new(attributes)
        article
      end
    end

    def self.upsert_home_articles(articles)
      transaction do
        articles.each(&:save!)
        unscoped.where.not(id: articles.map(&:id)).destroy_all
      end
    end
  end
end
