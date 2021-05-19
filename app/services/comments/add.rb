module Comments
  class Add
    include Service

    def initialize(to:, user:, content:, parent_id: nil)
      @commentable = to
      @user = user
      @content = content
      @parent_id = parent_id
    end

    def call
      if @parent_id
        @parent = @commentable.comments.find(@parent_id)
        @thread = @parent.thread || @parent
      end

      comment = Comment.new(content: @content, commentable: @commentable, user: @user, thread: @thread, parent: @parent)

      if comment.save
        success(comment)
      else
        failed(comment)
      end
    end
  end
end