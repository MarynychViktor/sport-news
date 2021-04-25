module CMS
  class TeamsController < ApplicationController
    before_action :find_category

    def new
      @team = Team.new
      render 'form'
    end

    def create
      @team = Team.create(team_params)

      if @team.valid?
        draw_column
      else
        render 'form'
      end
    end

    def appear
      @team.appear!
      draw_column
    end

    def hide
      @team.hide!
      draw_column
    end

    def edit
      render 'form'
    end

    def update
      @team.update(team_params)

      if @team.valid?
        draw_column
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
        draw_column
      else
        head status: 403
      end
    end

    def destroy
      @team.destroy!
      draw_column
    end

    private

    def draw_column
      @categories = Category.all
      render 'column'
    end

    def team_params
      params.require(:team).permit(:name, :subcategory_id)
    end

    def find_category
      @subcategory = Subcategory.find(params[:subcategory_id])
      @categories = Category.all
      @team = Team.find(params[:id]) if params[:id]
    end
  end
end