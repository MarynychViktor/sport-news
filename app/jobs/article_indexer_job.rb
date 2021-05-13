class ArticleIndexerJob < ApplicationJob
  queue_as :elasticsearch

  def perform(id)
    entity = Article.find_by_id(id)

    if entity.nil? || !entity.published?
      delete_if_exists(id)
      return
    end

    reindex(id, body: entity.as_indexed_json)
  end

  private

  def delete_if_exists(id)
    client.delete(index: 'articles', id: id) if client.exists?(index: 'articles', id: id)
  end

  def reindex(id, body:)
    client.index index: 'articles', id: id, body: body
  end

  def client
    @client ||= Elasticsearch::Model.client
  end
end
