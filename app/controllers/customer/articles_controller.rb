module Customer
  class ArticlesController < ApplicationController
    def index
      @most_commented = Article.most_commented(max: 3)
      @most_popular = Article.most_popular(max: 3)


      @ars = paginate(Article.where(category_id: 3))



      puts "----after"
      @category = Category.find(params[:category_id]) if params[:category_id]
      @subcategory = Subcategory.find(params[:subcategory_id]) if params[:subcategory_id]
      @team = Team.find(params[:team_id]) if params[:team_id]

      @articles = Article.take(1)
      @other_articles = Article.offset(1).take(4)
      @article = Article.first
    end

    def show
      @article = Article.friendly.find(params[:id])
    end
  end
end
