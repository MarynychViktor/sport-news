module Pagination
  extend ActiveSupport::Concern

  # TODO: review. Maybe provide more comfortable api
  def paginate(resource)
    paginated = resource.page(params[:page]).per(params[:limit])
    { data: paginated, total: paginated.total_count, page: paginated.current_page, last_page: paginated.last_page? }
  end
end
