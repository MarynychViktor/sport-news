class CategoriesController < ApplicationController
  include SportNews::Deps[:category_service]

  def index
    @categories = category_service.list
    render json: @categories
  end

  def subcategories
    @categories = category_service.list_subcategories params[:category_id]
    render json: @categories
  end

  def create
    request = build_request(CategoryRequest::Create)
    render json: [errors: request.errors.to_h], status: :bad_request and return if request.invalid?

    @category = category_service.create(name: params[:name])
    render json: @category
  end

  def create_subcategory
    request = build_request(CategoryRequest::CreateSubcategory)
    render json: [errors: request.errors.to_h], status: :bad_request and return if request.invalid?

    @category = category_service.create_subcategory(category_id: request[:category_id], name: request[:name])
    render json: @category
  end

  def update
    request = build_request(CategoryRequest::Update)
    render json: [errors: request.errors.to_h], status: :bad_request and return if request.invalid?

    if request[:hidden]
      category_service.mark_hidden params[:id]
    else
      category_service.mark_visible params[:id]
    end

    render json: nil
  end

  def destroy
    category_service.destroy params[:id]
    render json: nil
  end
end
