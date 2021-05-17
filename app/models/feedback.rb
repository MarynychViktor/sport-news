class Feedback < ApplicationRecord
  belongs_to :feedbackable, polymorphic: true
  belongs_to :user
end
