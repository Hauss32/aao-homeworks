class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(params[:email], params[:password])
        
        if user
            log_in_user!
            redirect_to root_url
        else
            flash.now[:errors] = 'Invalid Username/Password. Please try again.'
            flash.now[:email] = params[:email]
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end
end
