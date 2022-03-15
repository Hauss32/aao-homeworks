class UsersController < ApplicationController
    before_action :require_no_user!

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
            login_user!
        else
            render json: user.errors.full_messages
        end
    end
end
