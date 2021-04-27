module CategoryHelper
  def categories_count
    @categories_count || 0
  end

  def categories_count=(val)
    @categories_count = val
  end
end

World(CategoryHelper)