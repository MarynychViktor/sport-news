module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: 'alert') do
        concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def strip_tags_with_spaces(str)
    strip_tags(str&.gsub('><', '> <'))
  end

  def non_en_locales
    I18n.available_locales.reject { |locale| locale == :en }
  end

  def locale_name(locale)
    { en: 'English', ru: 'Russian', ua: 'Ukrainian' }.fetch(locale.to_sym)
  end
end
