class UsersController < ApplicationController
    before_action :require_no_user!, only: [:create, :new]

    def create
        @user = User.new
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]

        if @user.save
            session[:session_token] = @user.session_token
            redirect_to root_url
        else
            redirect_to new_user_url
        end
    end

    def new
        render 'new_user'
    end

end