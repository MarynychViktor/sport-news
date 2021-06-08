# == Schema Information
#
# Table name: languages
#
#  id          :bigint           not null, primary key
#  hidden      :boolean          default(FALSE)
#  locale      :string           not null
#  system      :boolean          default(FALSE)
#  translation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_languages_on_locale  (locale) UNIQUE
#
class Language < ApplicationRecord
  include Hideable
  before_destroy :check_if_can_be_destroyed

  after_save :sync_i18n_settings
  after_destroy :sync_i18n_settings

  def check_if_can_be_destroyed
    return true unless system?

    errors.add(:base, :immutable, "Record is system and can't be destroyed")
    false
  end

  def self.available_locales
    visible.map(&:locale).map(&:to_sym)
  end

  private

  def sync_i18n_settings
    I18n.available_locales = Language.available_locales
    I18n.backend.reload!
  end
end
