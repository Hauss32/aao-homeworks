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
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end

end