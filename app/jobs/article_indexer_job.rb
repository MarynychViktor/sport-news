class ArticleIndexerJob < ApplicationJob
  queue_as :elasticsearch

  Client = Elasticsearch::Model.client

  def perform(operation, model_id)
    case operation
    when :index
      Article.find(model_id).__elasticsearch__.index_document
    when :destroy
      Client.delete index: 'articles', id: model_id
    else
      raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
