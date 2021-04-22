class TeamsController < ApplicationController
  include SportNews::Deps[:teams_service]

  def index
    @teams = teams_service.list params[:category_id]
    render json: @teams
  end

  def create
    request = build_request(TeamRequest::Create)
    render json: [errors: request.errors.to_h], status: :bad_request and return if request.invalid?

    @team = teams_service.create(category_id: request[:category_id], name: request[:name])
    render json: @team
  end

  def update
    request = build_request(TeamRequest::Update)
    render json: [errors: request.errors.to_h], status: :bad_request and return if request.invalid?

    if request[:hidden]
      teams_service.mark_hidden params[:id]
    else
      teams_service.mark_visible params[:id]
    end

    render json: nil
  end

  def destroy
    teams_service.destroy params[:id]
    render json: nil
  end
end
