module Articles
  class CreateService
    include Service

    def initialize(category, params)
      @category = category
      @location_id = params[:location]
      @params = params.slice(:subcategory_id, :team_id, :picture, :caption, :alt, :headline, :content,
                             :display_comments)
      @places_client = GooglePlacesClient.new
    end

    def call
      ActiveRecord::Base.transaction do
        @article = @category.articles.new(@params)
        @article.save!
        resolve_location
      end
      success(@article)
    rescue ActiveRecord::RecordInvalid
      failed(@article)
    end

    private

    def resolve_location
      return if !@location_id || @location_id.empty? || @article.location&.place_id == @location_id

      response = Locations::ResolveByPlaceIdService.call(@location_id)
      raise response.result if response.failed?

      @article.locations << response.result
    end
  end
end