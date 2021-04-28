module CMS::TeamsHelper
  def teams_path(category, subcategory)
    {
      hide: hide_cms_subcategory_team_path(category, subcategory),
      appear: appear_cms_subcategory_team_path(category, subcategory),
      edit: edit_cms_category_path(category, subcategory),
      delete: cms_category_path(category, subcategory)
    }
  end
end
