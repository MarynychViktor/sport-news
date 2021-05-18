module Customer
  class CommentsController < ApplicationController
    before_action :authenticate_user!, except: %i[index]

    def index
      @article = Article.friendly.find(params[:article_id])
      authorize @article, :show?

      @comments = Comments::FindQuery.call({ article_id: @article.id }, order: params[:order])
      @result = paginate(@comments)
    end

    def create
      @article = Article.friendly.find(params[:article_id])
      authorize @article, :comment?
      @comment = Comment.new({ **comment_params.to_hash, article: @article, user: current_user })

      if @comment.save
        render :show
      else
        render json: @comment.errors, status: 400
      end
    end

    def update
      @comment = Comment.find(params[:id])
      authorize @comment

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
      authorize @comment
      @comment.destroy!

      render json: []
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :parent_id, :thread_id)
    end
  end
end
