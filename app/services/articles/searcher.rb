module Articles
  class Searcher
    def search_by_title(query, page: 1, limit: 5)
      search_result = Elasticsearch::Model.search(build_query(query, page: page, limit: limit), [Article])

      total_results = search_result.response[:hits][:total][:value]
      items = search_result.results.map { |r| map_response_to_model(r) }

      { data: items, total: total_results, page: page, last_page: page * limit >= total_results }
    end

    private

    def map_response_to_model(response)
      model = Article.find(response[:_id])
      model.highlighted_headline = response[:highlight][:headline].join(' ')
      model
    end

    def build_query(query_string, page:, limit:)
      {
        query: {
          multi_match: {
            query: query_string,
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
        _source: ['_id'],
        size: limit,
        from: (page - 1) * limit
      }
    end
  end

end