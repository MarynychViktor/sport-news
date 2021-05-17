class Comment < ApplicationRecord
  has_many :children, class_name: 'Comment', foreign_key: 'thread_id', dependent: :destroy
  belongs_to :thread, class_name: 'Comment', foreign_key: 'thread_id', counter_cache: :children_count, optional: true

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :feedbacks, as: :feedbackable
  belongs_to :user
  belongs_to :article

  validates :content, presence: true, length: { minimum: 1, maximum: 255 }

  after_update { self.edited = true unless edited }

  def like(user)
    feedback = user_feedback(user_id: user.id)
    feedback.positive = true
    feedback.save
  end

  def dislike(user)
    feedback = user_feedback(user_id: user.id)
    feedback.positive = false
    feedback.save
  end

  private

  def user_feedback(user)
    feedbacks.find_or_initialize_by(user_id: user.id)
  end
end
