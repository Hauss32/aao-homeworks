class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(
            params[:session][:email], 
            params[:session][:password])
        
        if user
            log_in_user!(user)
        else
            flash.now[:errors] = ['Invalid Username/Password. Please try again.']
            flash.now[:email] = params[:session][:email]
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end

    def destroy
        log_out_user!
    end
end
