module Customer
  class CommentsController < ApplicationController
    before_action :require_authenticated

    def index
      @article = Article.friendly.find(params[:article_id])
      @comments = Comments::FindQuery.call({ article_id: @article.id }, order: params[:order])
      @result = paginate(@comments)
    end

    def create
      @article = Article.friendly.find(params[:article_id])
      @comment = Comment.new({ **comment_params.to_hash, article: @article, user: current_user })

      if @comment.save
        render :show
      else
        render json: @comment.errors, status: 400
      end
    end

    def update
      @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        render :show
      else
        render json: @comment.errors, status: 400
      end
    end

    def like
      @comment = Comment.find(params[:id])
      current_user.like_comment!(@comment)

      render :show
    end

    def dislike
      @comment = Comment.find(params[:id])
      current_user.dislike_comment!(@comment)

      render :show
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy!

      head :ok
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
