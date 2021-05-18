module Comments
  class FindQuery
    include CallableQuery

    PREDEFINED_ORDERS = {
      newest: { created_at: :asc },
      oldest: { created_at: :desc },
      popular: { children_count: :desc }
    }.freeze

    def initialize(relation = Comments.all, order: nil, direction: :desc)
      @relation = relation
      @order = order
      @direction = direction
      super()
    end

    def call
      @relation = @relation.root
                           .with_author
                           .with_children
                           .with_feedbacks

      order_by(column: @order, direction: @direction)
    end

    private

    def order_by(column:, direction: desc)
      column ||= :popular
      order_params = if PREDEFINED_ORDERS.key? column
                       PREDEFINED_ORDERS[column]
                     else
                       Hash[column, direction]
                     end

      @relation.order(order_params)
    end
  end
end
