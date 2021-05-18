class CommentDto
  attr_accessor :children, :thread, :parent, :content,

    def initialize(data)
      @data = data
    end
end