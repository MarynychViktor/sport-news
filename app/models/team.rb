class Team < ApplicationRecord
  include Hideable

  belongs_to :subcategory
end
