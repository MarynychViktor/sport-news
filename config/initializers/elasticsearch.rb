Elasticsearch::Model.client = Elasticsearch::Client.new(urls: ENV['ELASTICSEARCH_URLS'])
