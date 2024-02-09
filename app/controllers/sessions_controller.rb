class SessionsController < ApplicationController

    def new
      
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        flash[:notice] = "Logged in successfuly"
        redirect_to user
      else
        flash[:alert] = "something wrong"
        redirect_to root_path
      end
    end

    def destroy 
    end
end