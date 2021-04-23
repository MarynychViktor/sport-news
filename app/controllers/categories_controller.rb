class CategoriesController < ApplicationController
  include SportNews::Deps[:category_service]

  validate_request CategoryRequest::Create, method: :create
  validate_request CategoryRequest::Update, method: :update
  validate_request CategoryRequest::CreateSubcategory, method: :create_subcategory

  def index
    @categories = category_service.list
    render json: @categories
  end

  def subcategories
    @categories = category_service.list_subcategories(req[:category_id])
    render json: @categories
  end

  def create
    @category = category_service.create(name: req[:name])
    render json: @category
  end

  def create_subcategory
    @category = category_service.create_subcategory(category_id: req[:category_id], name: req[:name])
    render json: @category
  end

  def update
    if req[:hidden]
      category_service.mark_hidden(req[:id])
    else
      category_service.mark_visible(req[:id])
    end

    render json: nil
  end

  def destroy
    category_service.destroy(req[:id])
    render json: nil
  end
end
