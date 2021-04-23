class TeamsController < ApplicationController
  def index
    @teams = Team.all
    render json: @teams
  end

  def create
    @team = Team.create(create_params)
    render json: @team
  end

  def mark_visible
    @team = Team.find(params[:id])
    @team.mark_visible!
    render json: @team
  end

  def mark_hidden
    @team = Team.find(params[:id])
    @team.mark_hidden!
    render json: @team
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy(req[:id])
    render json: nil
  end

  private

  def create_params
    params.require(:team).permit(:id, :category_id)
  end
end
