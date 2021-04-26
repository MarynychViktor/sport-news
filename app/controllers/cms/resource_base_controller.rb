module CMS
  class ResourceBaseController < ApplicationController
    def create
      self.model = model_class.create(create_params)

      if model.valid?
        render_column
      else
        render 'form'
      end
    end

    def edit
      render 'form'
    end

    def update
      model.update(update_params)

      if model.valid?
        render_column
      else
        render 'form'
      end
    end

    def appear
      model.appear!
      render_column
    end

    def hide
      model.hide!
      render_column
    end

    def change_position
      model.update_position! params[:position]
      head :ok
    end

    def destroy
      model.destroy!
      render_column
    end

    private

    def model_class
      model.class
    end
  end
end