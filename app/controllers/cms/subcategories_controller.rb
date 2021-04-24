module CMS
  class SubcategoriesController < ApplicationController
    before_action :find_category

    def new
      @category = Category.find(params[:category_id])
      @subcategory = Subcategory.new
    end

    def create
      @subcategory = Subcategory.create(create_params)
      # binding.pry
    end

    def mark_visible
      @subcategories = Category.find(params[:id])
      @subcategories.mark_visible!
      render json: @subcategories
    end

    def mark_hidden
      @subcategories = Category.find(params[:id])
      @subcategories.mark_hidden!
      render json: @subcategories
    end

    def destroy
      @subcategories = Category.create(create_params)
      head :ok
    end

    private

    def create_params
      params.require(:subcategory).permit(:name, :category_id)
    end

    def find_category
      @category = Category.find(params[:category_id])
    end
  end
end