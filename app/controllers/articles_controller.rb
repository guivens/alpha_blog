class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]

    def show
    end

    def index
        @articles = Article.all
    end

    def new
    end

    def create
        @article = Article.new(article_params)
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
        params.require(:article).permit(:title, :description)
    end

end