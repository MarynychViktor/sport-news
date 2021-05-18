class CommentDto
  attr_accessor :children, :thread, :parent, :content

  # comment.as_json(include: {user: {}, feedbacks: {}, children: {include: [:user, :feedbacks, :thread, :parent] }, thread: {}, parent: {}})
    def initialize(comment)
      @model = comment
    end
end