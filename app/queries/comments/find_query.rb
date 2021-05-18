module Comments
  class FindQuery < BaseQuery
    def initialize
      @query_builder = QueryBuilder.new
      super
    end

    def call(params, order: nil, direction: :desc)
      @query_builder.root
                    .with_author
                    .with_children
                    .with_feedbacks
                    .find_by(params)
                    .order_by(order, direction: direction)
                    .result
    end
  end
end
