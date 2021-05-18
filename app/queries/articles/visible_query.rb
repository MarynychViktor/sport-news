module Articles
  class VisibleQuery
    include CallableQuery

    def initialize(relation = Article.all)
      @relation = relation
    end

    def call
      @relation.includes(:category, :subcategory, :team)
              .where(category: { hidden: [false, nil] },
                     subcategory: { hidden: [false, nil] },
                     team: { hidden: [false, nil] })
    end
  end
end

