class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render json: @categories
  end

  def create
    @category = Category.create(create_params)
    render json: @category
  end

  def mark_visible
    @category = Category.find(params[:id])
    @category.mark_visible!
    render json: @category
  end

  def mark_hidden
    @category = Category.find(params[:id])
    @category.mark_hidden!
    render json: @category
  end

  def destroy
    @category = Category.create(create_params)
    render json: nil
  end

  private

  def create_params
    params.require(:team).permit(:id, :category_id)
  end
end
