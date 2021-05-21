# == Schema Information
#
# Table name: home_settings
#
#  id                        :bigint           not null, primary key
#  commented_articles_period :string           default("day"), not null
#  popular_articles_period   :string           default("day"), not null
#  show_commented_articles   :boolean          default(TRUE), not null
#  show_popular_articles     :boolean          default(TRUE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
module Home
  # TODO: apply singleton pattern
  class Setting < ApplicationRecord
    validates_inclusion_of :show_popular_articles, :show_commented_articles, in: [true, false]

    def self.instance
      first_or_initialize
    end
  end
end
