class UsersController < ApplicationController
    before_action :find_params, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the alpha blog #{@user.username} "
            redirect_to @user
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to @user
        else
            render :edit
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account delete"
        redirect_to root_path
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def find_params 
        @user = User.find(params[:id])
    end

    def same_user
        if current_user != @user
            flash[:alert] = "you can only modified your account"
            redirect_to user_path
        end
    end

end