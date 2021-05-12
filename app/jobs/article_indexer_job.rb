class ArticleIndexerJob < ApplicationJob
  queue_as :elasticsearch

  Client = Elasticsearch::Model.client

  def perform(operation, model_id)
    case operation
    when :index
      model = Article.find(model_id)
      Client.index index: 'articles', id: model_id, body: model.as_indexed_json
    when :destroy
      Client.delete index: 'articles', id: model_id
    else
      raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
