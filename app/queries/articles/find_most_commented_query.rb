module Articles
  class FindMostCommentedQuery
    include CallableQuery

    def initialize(limit = 4, relation = Article.all)
      @relation = relation
      @limit = limit
    end

    def call
      @relation.left_joins(:comments)
               .group(:id)
               .order('count(comments.id) desc')
               .limit(@limit)
    end
  end
end

