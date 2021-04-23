class SubcategoriesController < ApplicationController
  def index
    @subcategories = Subcategory.all
    render json: @subcategories
  end

  def create
    @subcategories = Category.create(create_params)
    render json: @subcategories
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
    params.require(:team).permit(:id, :category_id)
  end
end
