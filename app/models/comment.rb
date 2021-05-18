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
