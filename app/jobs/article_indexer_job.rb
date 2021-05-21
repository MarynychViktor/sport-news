class ArticleIndexerJob < ApplicationJob
  queue_as :elasticsearch

  def perform(id)
    logger.info("Starting indexer for article: #{id}")
    article = Article.find_by_id(id)

    if article.nil? || !article.published?
      delete_if_exists(id)
      return
    end

    reindex(id, body: build_body(article))
  end

  private

  def delete_if_exists(id)
    logger.info("Deleting article: #{id} from index")
    client.delete(index: 'articles', id: id) if client.exists?(index: 'articles', id: id)
  end

  def reindex(id, body:)
    logger.info("Reindexing article: #{id}")
    client.index index: 'articles', id: id, body: body
  end

  def client
    @client ||= Elasticsearch::Model.client
  end

  def build_body(article)
    content = article.as_json(only: %i[id location headline content])
    content['content'] = ActionController::Base.helpers.strip_tags(content['content'].gsub('><', '> <')).strip
    content
  end
end
