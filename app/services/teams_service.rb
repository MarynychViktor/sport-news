class TeamsService
  include SportNews::Deps[:category_service]

  # TODO: pagination ?!
  def list(category_id)
    Team.where(category_id: category_id)
  end

  def create(category_id:, name:)
    category = category_service.find(category_id)
    category.teams.create!(name: name)
  end

  def mark_hidden(id)
    team = Team.find(id)
    team.mark_hidden!
  end

  def mark_visible(id)
    team = Team.find(id)
    team.mark_visible!
  end

  def destroy(id)
    team = Team.find(id)
    team.destroy!
  end
end
