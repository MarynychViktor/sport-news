class TeamsController < ApplicationController
  include SportNews::Deps[:teams_service]

  validate_request TeamRequest::Create, method: :create
  validate_request TeamRequest::Update, method: :update

  def index
    @teams = teams_service.list req[:category_id]
    render json: @teams
  end

  def create
    @team = teams_service.create(category_id: req[:category_id], name: req[:name])
    render json: @team
  end

  def update
    if req[:hidden]
      teams_service.mark_hidden(req[:id])
    else
      teams_service.mark_visible(req[:id])
    end

    render json: nil
  end

  def destroy
    teams_service.destroy(req[:id])
    render json: nil
  end
end
