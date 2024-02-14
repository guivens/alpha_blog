class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :same_user, only: [:edit, :update, :destroy]

    def show
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        @article.save
        flash[:notice] = "Article was create successfully"
        redirect_to @article
    end

    def edit
    end

    def update
        @article.update(article_params)
        flash[:notice] = "Article was update successfully"
        redirect_to @article
    end

    def destroy
        @article.destroy
        redirect_to @article
    end


    private

    def find_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, category_ids: [] )
    end

    def same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "you can only modified your own article"
            redirect_to @article
        end
    end

end