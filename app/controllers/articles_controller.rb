class ArticlesController < ApplicationController

  def index
    @articles = current_user.articles.order(id: :desc).page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: 'New article has been posted'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :published, :published_at, :body)
  end
end
