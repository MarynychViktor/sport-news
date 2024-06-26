class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :find_comment, only: %i[update like dislike destroy]

  def index
    @article = Article.friendly.find(params[:article_id])
    authorize @article, :show?
    @comments = Comments::FindQuery.call(@article.comments, order: params[:order])
    @result = paginate(@comments)
  end

  def create
    @article = Article.friendly.find(params[:article_id])
    authorize @article, :comment?
    response = Comments::AddService.call(to: @article, user: current_user, content: comment_params[:content],
                                         parent_id: comment_params[:parent_id])
    @comment = response.comment

    if response.success?
      render :show
    else
      render json: @comment.errors, status: 400
    end
  end

  def update
    authorize @comment

    if @comment.update(comment_params)
      render :show
    else
      render json: @comment.errors, status: 400
    end
  end

  def like
    Comments::LikeService.call(user: current_user, comment: @comment)
    render :show
  end

  def dislike
    Comments::DislikeService.call(user: current_user, comment: @comment)
    render :show
  end

  def destroy
    authorize @comment
    @comment.destroy!

    head :ok
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
