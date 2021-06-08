begin
  I18n.available_locales = Language.visible.map(&:locale)
rescue ActiveRecord::ActiveRecordError
  # Suppress activerecord errors
end

I18n.backend = I18n::Backend::Chain.new(
  I18nExtensions::HybridBackend.new(ENV['REDIS_I18N_STORAGE_URL']),
  I18n::Backend::Simple.new
)
