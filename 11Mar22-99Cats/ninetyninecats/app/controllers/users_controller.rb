class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        user = User.new(
            username: params[:user][:username], 
            password: params[:user][:password])

        if user.save
            session[:session_token] = user.session_token
            redirect_to root_url
        else
            render json: user.errors.full_messages
        end
    end
end
