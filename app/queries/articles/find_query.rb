module Articles
  class FindQuery
    include CallableQuery

    def initialize(params, relation = Article.all, order_by: { created_at: :desc })
      @params = params.dup
      @relation = relation
      @order_by = order_by
    end

    def call
      published = @params.extract!(:published).fetch(:published, nil)
      query = @relation.where(@params)
      query = published ? query.public_send(published) : query
      query.order(@order_by)
    end
  end
end

