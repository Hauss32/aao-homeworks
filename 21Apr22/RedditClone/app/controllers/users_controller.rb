class UsersController < ApplicationController
    def create
        @user = User.new(user_params)

        if @user.save
            log_in_user(@user)
        else
            @email = params[:email]
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
