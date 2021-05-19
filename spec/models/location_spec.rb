# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :string           not null
#
# Indexes
#
#  index_locations_on_place_id  (place_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
