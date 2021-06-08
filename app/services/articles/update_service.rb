module Articles
  class UpdateService
    include Service

    def initialize(category, article, params)
      @category = category
      @article = article
      @location_id = params[:location]
      @params = params.slice(:subcategory_id, :team_id, :picture, :caption, :alt, :headline, :content,
                             :display_comments)
      @places_client = GooglePlacesClient.new
    end

    def call
      ActiveRecord::Base.transaction do
        @article.update!(@params)
        resolve_location
      end
      success(article: @article)
    rescue ActiveRecord::RecordInvalid
      failed(article: @article)
    end

    private

    def resolve_location
      return if !@location_id || @location_id.empty? || @article.location&.place_id == @location_id

      response = Locations::ResolveByPlaceIdService.call(@location_id)
      raise response.error if response.failed?

      @article.locations.clear
      @article.locations << response.location
    end
  end
end