class UsersController < ApplicationController
    before_action :find_params, only: [:show, :edit, :update]

    def index
        @users = User.all
    end

    def show
        @articles = @user.articles
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the alpha blog #{@user.username} "
            redirect_to articles_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to articles_path
        else
            render :edit
        end
        
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password_digest)
    end

    def find_params 
        @user = User.find(params[:id])
    end



end