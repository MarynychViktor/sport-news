Sidekiq.configure_server do |config|
  config.logger.level = Logger::INFO
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end