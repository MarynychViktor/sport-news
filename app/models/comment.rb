# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  children_count   :integer          default(0)
#  commentable_type :string
#  content          :text             not null
#  edited           :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :bigint
#  thread_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_parent_id  (parent_id)
#  index_comments_on_thread_id  (thread_id)
#  index_comments_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => comments.id)
#  fk_rails_...  (thread_id => comments.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  has_many :children, class_name: 'Comment', foreign_key: 'thread_id', dependent: :destroy
  belongs_to :thread, class_name: 'Comment', foreign_key: 'thread_id', counter_cache: :children_count, optional: true

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :feedbacks, as: :feedbackable
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true, length: { minimum: 1, maximum: 255 }

  scope :root, -> { where(parent_id: nil) }
  scope :with_author, -> { includes(:user) }
  scope :with_children, -> { includes(children: %i[user feedbacks parent thread]) }
  scope :with_feedbacks, -> { includes(:feedbacks) }

  after_update { self.edited = true unless edited }
end
