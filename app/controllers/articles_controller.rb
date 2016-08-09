class ArticlesController < ApplicationController
  #un tipo de "callback"
  #before_action :valita_user, except: [:show, :index]
  before_action :authenticate_user!, except: [:show, :index]
  # before_action :set_article, except: [:index, :new, :create]
  #o sino
  #before_action :authenticate_user!, except: [:show, :index]


  #GET /articles
  def index
    # Retorna todos los articulos
    @articles = Article.all
  end

  #GET /articles/:id
  def show
    # Encuentra un registro por su ID
    @article = Article.find(params[:id])
    @article.update_visits_count
    @comment = Comment.new
  end

  #GET /articles/new
  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  #POST /articles
  def create
    #@article = Article.new(title: params[:article][:title],body: params[:article][:body])
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  #DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  #UPDATE /articles/:id
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  private

  def validate_user
    redirect_to new_user_session_path, notice: "Necesitas iniciar sesion"
  end

  def article_params
    params.require(:article).permit(:title,:body)
  end

end
