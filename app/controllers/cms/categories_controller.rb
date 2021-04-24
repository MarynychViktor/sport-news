module CMS
  class CategoriesController < ApplicationController
    before_action :find_category, only: %i[edit update appear hide destroy]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.create(category_params)
    end

    def update
      @category.update(category_params)
    end

    def appear
      @category.mark_visible!
    end

    def hide
      @category.mark_hidden!
    end

    def destroy
      @category.destroy!
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find(params[:id])
    end
  end
end