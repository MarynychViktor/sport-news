module Comments
  class AddService
    include Service

    def initialize(to:, user:, content:, parent_id: nil)
      @commentable = to
      @user = user
      @content = content
      @parent_id = parent_id if parent_id && !parent_id.to_s.empty?
    end

    def call
      if @parent_id
        @parent = @commentable.comments.find(@parent_id)
        @thread = @parent.thread || @parent
      end

      comment = Comment.new(content: @content, commentable: @commentable, user: @user, thread: @thread, parent: @parent)

      if comment.save
        success(comment: comment)
      else
        failed(comment: comment)
      end
    end
  end
end