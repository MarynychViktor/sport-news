module CMS
  class SubcategoriesController < ApplicationController
    before_action :find_category

    def new
      @subcategory = Subcategory.new
      render 'form'
    end

    def create
      @subcategory = Subcategory.create(subcategory_params)

      if @subcategory.valid?
        draw_column
      else
        render 'form'
      end
    end

    def appear
      @subcategory.appear!
      draw_column
    end

    def hide
      @subcategory.hide!
      draw_column
    end

    def edit
      render 'form'
    end

    def update
      @subcategory.update(subcategory_params)

      if @subcategory.valid?
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
      @new_category = Category.find(params[:new_category_id])

      if @subcategory.category_id != @new_category.id
        @subcategory.update!(category_id: @new_category.id)
        draw_column
      else
        head status: 403
      end
    end

    def destroy
      @subcategory.destroy!
      draw_column
    end

    private

    def draw_column
      render 'column'
    end

    def subcategory_params
      params.require(:subcategory).permit(:name, :category_id)
    end

    def find_category
      @category = Category.find(params[:category_id])
      @subcategory = Subcategory.find(params[:id]) if params.key? :id
    end
  end
end