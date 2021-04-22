class Team < ApplicationRecord
  include Hideable

  belongs_to :category
end
