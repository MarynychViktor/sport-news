module Customer
  class CommentsController < ApplicationController
    before_action :require_authenticated

    def index
      @article = Article.friendly.find(params[:article_id])

      builder = Comments::FindQuery.call({ article_id: @article.id }, order: params[:order])
      result = paginate(builder)

      # TODO: add response
      render json: { **result, data: result[:data]
          .map  do |comment|
            comment.as_json(include: {user: {}, feedbacks: {}, children: {include: [:user, :feedbacks, :thread, :parent] }, thread: {}, parent: {}})
            # comment.as_json(include: [:user, :feedbacks, [children: {include: [:user, :feedbacks, :thread, :parent] }], :thread, :parent])
          end
      }
    end

    def new
      @article = Article.friendly.find(params[:article_id])
      @comment = Comment.new(comment_params)
    end

    def create
      @article = Article.friendly.find(params[:article_id])
      @comment = Comment.new({ **comment_params.to_hash, article: @article, user: current_user })

      if @comment.save
        render json: @comment
      else
        render json: @comment.errors, status: 400
      end
    end

    def edit
      @comment = Comment.find(params[:id])
      @article = @comment.article
    end

    def update
      @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        render :update
      else
        head status: 400
      end
    end

    def like
      @comment = Comment.find(params[:id])

      if @comment.like
      else
      end
    end

    def dislike
      @comment = Comment.find(params[:id])

      if @comment.dislike
      else
      end
    end

    def destroy
      @comment = Comment.find(params[:id])

      if @comment.destroy
        respond_to do |format|
          format.js
        end
      else
        head status: 400
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :parent_id, :thread_id)
    end

    # TODO: check for built-in ready method
    def require_authenticated
      redirect_to new_user_session_path unless user_signed_in?
    end

    def orders(order = :popular)
      case order
      when :oldest
        { updated_at: :asc }
      when :newest
        { updated_at: :desc }
      else
        { children_count: :desc }
      end
    end
  end
end
