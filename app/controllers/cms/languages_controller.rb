module CMS
  class LanguagesController < ApplicationController
    before_action :find_language, except: %i[index create]

    def index
      @languages = Language.order(:id)
      @locales_in_use = Language.available_locales
    end

    def create
      @language = Language.new(create_params)

      if @language.save
        redirect_to cms_languages_path
      else
        render json: @language.errors, status: 400
      end
    end

    def update
      if @language.update(update_params)
        redirect_to cms_languages_path
      else
        render json: [], status: 400
      end
    end

    def destroy
      @language.destroy!

      redirect_to cms_languages_path
    end

    private

    def find_language
      @language = Language.find(params[:id])
    end

    def create_params
      params.require(:language).permit(:locale)
    end

    def update_params
      params.require(:language).permit(:translation, :hidden)
    end
  end
end
