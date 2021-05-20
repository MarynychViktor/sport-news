module CMS
  class SubcategoriesController < ApplicationController
    before_action :find_category_and_subcategory
    before_action :retrieve_categories, only: %i[index create appear hide update update_category destroy]

    # TODO: review action. Do we need all categories?
    def index
      respond_to do |format|
        format.html
        format.json { render json: paginate(@category.subcategories) }
        format.js { render :column }
      end
    end

    def new
      @subcategory = Subcategory.new
      render :form
    end

    def create
      @subcategory = Subcategory.create(subcategory_params)

      if @subcategory.valid?
        render :column
      else
        render :form
      end
    end

    def appear
      @subcategory.appear!
      render :column
    end

    def hide
      @subcategory.hide!
      render :column
    end

    def edit
      render :form
    end

    def update
      @subcategory.update(subcategory_params)

      if @subcategory.valid?
        render :column
      else
        render :form
      end
    end

    def update_category
      @new_category = Category.find(params[:new_category_id])

      if @subcategory.category_id != @new_category.id
        @subcategory.update!(category_id: @new_category.id)
        render :column
      else
        head status: 403
      end
    end

    def change_position
      @subcategory.update_position! params[:position]
      head :ok
    end

    def destroy
      @subcategory.destroy!
      render :column
    end

    private

    def subcategory_params
      params.require(:subcategory).permit(:name, :category_id)
    end

    def retrieve_categories
      @categories = Category.all
    end

    def find_category_and_subcategory
      @category = Category.find(params[:category_id])
      @subcategory = Subcategory.find(params[:id]) if params.key? :id
    end
  end
end
