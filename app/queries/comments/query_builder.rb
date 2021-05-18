module Comments
  class QueryBuilder
    PREDEFINED_ORDERS = {
      newest: { created_at: :asc },
      oldest: { created_at: :desc },
      popular: { children_count: :desc }
    }.freeze

    def initialize
      @resource = Comment.all
    end

    def root
      @resource = @resource.where(parent_id: nil)
      self
    end

    def with_author
      @resource = @resource.includes(:user)
      self
    end

    def with_parent
      @resource = @resource.includes(:parent)
      self
    end

    def with_thread
      @resource = @resource.includes(:thread)
      self
    end

    def with_children(relations: nil)
      relations ||= %i[user feedbacks parent thread]
      @resource = @resource.includes(children: relations)
      self
    end

    def with_feedbacks
      @resource = @resource.includes(:feedbacks)
      self
    end

    def find_by(params)
      @resource = @resource.where(params)
      self
    end

    def order_by(column, direction: desc)
      column ||= :popular
      order_params = if PREDEFINED_ORDERS.key? column
                       PREDEFINED_ORDERS[column]
                     else
                       Hash[column, direction]
                     end

      @resource = @resource.order(order_params)
      self
    end

    def result
      @resource
    end
  end
end
