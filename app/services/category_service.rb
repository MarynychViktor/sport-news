class CategoryService
  # TODO: pagination ?!
  def list
    Category.root_categories
  end

  def list_subcategories(category_id)
    Category.find_by(id: category_id).children
  end

  def find(id)
    Category.find(id)
  end

  def create(name:)
    Category.create!(name: name)
  end

  def create_subcategory(category_id:, name:)
    category = Category.find(category_id)
    category.children.create!(name: name)
  end

  def mark_hidden(id)
    category = Category.find(id)
    category.mark_hidden!
  end

  def mark_visible(id)
    category = Category.find(id)
    category.mark_visible!
  end

  def destroy(id)
    category = Category.find(id)
    category.destroy!
  end
end
