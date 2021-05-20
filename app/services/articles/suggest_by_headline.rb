module Articles
  class SuggestByHeadline
    include Callable

    def initialize(query, page: 1, limit: 5)
      @query = query
      @page = page
      @limit = limit
    end

    def call
      elastic_query = build_elastic_query(@query, page: @page, limit: @limit)
      search_result = Elasticsearch::Model.search(elastic_query, [Article])

      total_results = search_result.response[:hits][:total][:value]
      items = search_result.results.map { |r| map_response_to_model(r) }

      { data: items, total: total_results, page: @page, last_page: @page * @limit >= total_results }
    end

    private

    def map_response_to_model(response)
      model = Article.find(response[:_id])
      model.highlighted_headline = response[:highlight][:headline].join(' ')
      model
    end

    def build_elastic_query(query_string, page:, limit:)
      {
        query: {
          multi_match: {
            query: query_string,
            # Maybe enable fuzzy search?
            # fuzziness: 1,
            fields: ['headline']
          }
        },
        highlight: {
          tags_schema: "styled",
          fields: {
            headline: {}
          }
        },
        size: limit,
        from: (page - 1) * limit
      }
    end
  end
end