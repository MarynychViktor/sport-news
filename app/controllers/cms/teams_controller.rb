module CMS
  class TeamsController < ApplicationController
    before_action :set_resource

    def new
      @team = Team.new
      render 'form'
    end

    def create
      @team = Team.create(team_params)

      if @team.valid?
        render 'column'
      else
        render 'form'
      end
    end

    def appear
      @team.appear!
      render 'column'
    end

    def hide
      @team.hide!
      render 'column'
    end

    def edit
      render 'form'
    end

    def update
      @team.update(team_params)

      if @team.valid?
        render 'column'
      else
        render 'form'
      end
    end

    def select_category
      @categories = Category.where.not(id: params[:category_id])

      render 'select_category', layout: false
    end

    def update_category
      @new_subcategory = Subcategory.find(params[:new_subcategory_id])

      if @team.subcategory_id != @new_subcategory.id
        @team.update!(subcategory_id: @new_subcategory.id)
        render 'column'
      else
        head status: 403
      end
    end

    def destroy
      @team.destroy!
      render 'column'
    end

    def change_position
      @team.update_position! params[:position]
      head :ok
    end

    private

    def team_params
      params.require(:team).permit(:name, :subcategory_id)
    end

    def set_resource
      @subcategory = Subcategory.find(params[:subcategory_id])
      @categories = Category.all
      @team = Team.find(params[:id]) if params[:id]
    end
  end
end