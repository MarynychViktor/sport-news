module CMS
  class TeamsController < ApplicationController
    before_action :find_subcategory_and_team

    def index
      @categories = Category.includes(:subcategories)
    end

    def new
      @team = Team.new
      render :form
    end

    def create
      @team = Team.create(team_params)

      if @team.valid?
        render_column
      else
        render :form
      end
    end

    def appear
      @team.appear!
      render_column
    end

    def hide
      @team.hide!
      render_column
    end

    def edit
      render :form
    end

    def update
      @team.update(team_params)

      if @team.valid?
        render_column
      else
        render :form
      end
    end

    def update_category
      @new_subcategory = Subcategory.find(params[:new_subcategory_id])

      if @team.subcategory_id != @new_subcategory.id
        @team.update!(subcategory_id: @new_subcategory.id)
        render_column
      else
        head status: 403
      end
    end

    def destroy
      @team.destroy!
      render_column
    end

    def change_position
      @team.update_position! params[:position]
      head :ok
    end

    private

    def team_params
      params.require(:team).permit(:name, :subcategory_id)
    end

    def render_column
      @categories = Category.includes(:subcategories)
      render :column
    end

    def find_subcategory_and_team
      @subcategory = Subcategory.find(params[:subcategory_id])
      @team = Team.find(params[:id]) if params[:id]
    end
  end
end