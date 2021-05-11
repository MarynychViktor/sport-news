module Home
  class Article < ApplicationRecord
    belongs_to :article, class_name: '::Article'
    validates :article_id, :category_id, presence: true
    attr_writer :category_id, :subcategory_id, :team_id
    validates_inclusion_of :show, in: [true, false]

    default_scope { includes(article: %i[category subcategory team]).order(:created_at) }

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
      params.map do |attributes|
        attributes[:show] ||= false
        article = ::Article.find_by_id(attributes[:article_id])
        home_article = find_or_initialize_by(article: article)
        home_article.assign_attributes(attributes)
        home_article
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
