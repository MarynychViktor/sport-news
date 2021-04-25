module CMS
  class CategoriesController < ApplicationController
    before_action :find_category, only: %i[edit update appear hide destroy]

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
        @categories = Category.all
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
      @category.destroy!
      draw_column
    end

    private

    def draw_column
      @categories = Category.all
      render 'column'
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find(params[:id])
    end
  end
end