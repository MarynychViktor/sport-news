# == Schema Information
#
# Table name: feedbacks
#
#  id                :bigint           not null, primary key
#  feedbackable_type :string
#  positive          :boolean          default(TRUE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  feedbackable_id   :bigint
#  user_id           :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Feedback < ApplicationRecord
  belongs_to :feedbackable, polymorphic: true
  belongs_to :user
end
