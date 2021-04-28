module CMS::CategoriesHelper
  def category_paths(category)
    {
      hide: hide_cms_category_path(category),
      appear: appear_cms_category_path(category),
      edit: edit_cms_category_path(category),
      delete: cms_category_path(category)
    }
  end
end
