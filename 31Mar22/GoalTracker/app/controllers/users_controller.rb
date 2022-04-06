class UsersController < ApplicationController
    def create
        @user = User.new(user_params)

        if @user.save
            log_in_user!(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end

    def show
        @user = User.find_by_id(params[:id])

        if @user.nil?
            render_not_found
        else
            @comments = @user.comments
            render 'user'
        end
    end

    private
    def user_params
        params[:user].permit(:email, :password)
    end
end
