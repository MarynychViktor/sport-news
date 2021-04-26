module CMS
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[edit update appear hide destroy change_position]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
      render 'form'
    end

    def create
      @category = Category.create(category_params)

      if @category.valid?
        draw_column
      else
        render 'form'
      end
    end

    def edit
      render 'form'
    end

    def update
      @category.update(category_params)

      if @category.valid?
        @categories = Category.all
        draw_column
      else
        render 'form'
      end
    end

    def appear
      @category.appear!
      draw_column
    end

    def hide
      @category.hide!
      draw_column
    end

    def destroy
      if !@category.static?
        @category.destroy!
        draw_column
      else
        head status: 403
      end
    end

    def change_position
      @category.update_position! params[:position]
      head :ok
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def draw_column
      @categories = Category.all
      render 'column'
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end