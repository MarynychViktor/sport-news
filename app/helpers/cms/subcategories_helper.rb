module CMS::SubcategoriesHelper
  def subcategory_paths(category, subcategory)
    {
      hide: hide_cms_category_subcategory_path(category, subcategory),
      appear: appear_cms_category_subcategory_path(category, subcategory),
      edit: edit_cms_category_subcategory_path(category, subcategory),
      delete: cms_category_subcategory_path(category, subcategory),
      select_parent: select_category_cms_category_subcategory_path(category, subcategory)
    }
  end
end
