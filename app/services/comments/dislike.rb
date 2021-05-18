module Comments
  class Dislike
    include CallableService

    def initialize(user:, comment:)
      @user = user
      @comment = comment
    end

    def call
      feedback = @comment.feedbacks.find_or_initialize_by(user_id: @user.id)

      if !feedback.persisted? || feedback.positive
        feedback.positive = false
        feedback.save!
      else
        feedback.destroy!
      end
    end
  end
end
