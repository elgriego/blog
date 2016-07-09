class ArticlesController < ApplicationController

  #GET /articles
  def index
    @articles = Article.all
  end
  #GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  #GET /articles/new
  def new
    @article = Article.new
  end
  #post /articles
  def create
    @article = Article.new(title: params[:article][:title],
                            body: params[:article][:body])
    if @article.save
      redirect_to @article
    else
      render :new
    end

  end
end
