module ApplicationHelper
  def strip_tags_with_spaces(str)
    strip_tags(str&.gsub('><', '> <'))
  end

  def non_en_locales
    I18n.available_locales.reject { |locale| locale == :en }
  end

  def supported_languages
    I18nExtensions::Languages::SUPPORTED_LANGUAGES
  end

  def locale_name(locale)
    supported_languages.fetch(locale.to_sym)
  end
end
