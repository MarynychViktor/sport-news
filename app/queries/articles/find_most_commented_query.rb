module Articles
  class FindMostCommentedQuery
    include CallableQuery

    def initialize(params: {}, limit: 3)
      @relation = Article.all
      @params = params
      @limit = limit
    end

    def call
      @relation.left_joins(:comments)
               .group(:id)
               .where(@params)
               .order('count(comments.id) desc')
               .limit(@limit)
    end
  end
end

