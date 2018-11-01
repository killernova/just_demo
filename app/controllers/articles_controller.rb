class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q].present?
      puts '???????????????????'
      @articles = Kaminari.paginate_array(Article.cached_search_result(params[:q])).page(params[:page])
    else
      @articles = Article.order(id: :desc).page(params[:page])
    end
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
    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'Updated succeeded'
    else
      flash.now[:alert] = "Faild to update: #{@articles.errors.full_messages.join(';')}"
      render :edit
    end
  end

  def show
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :published, :published_at, :body)
  end

  def set_article
    @article = Article.find params[:id]
  end
end
