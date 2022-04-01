class UsersController < ApplicationController
    def create
        @user = User.new(user_params)

        if @user.save
            session[:session_token] = @user.session_token
            log_in_user!
        else
            flash.now[:errors] = @user.errors.full_messages
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end

    private
    def user_params
        params[:user].permit(:email, :password)
    end
end
