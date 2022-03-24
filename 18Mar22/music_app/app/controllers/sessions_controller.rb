class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(
            params[:session][:email],
            params[:session][:password]
        )

        if user
            session[:session_token] = user.session_token
            log_in_user!
        else  
            flash.now[:error] = 'Invalid Credentials. Please try again.'
            flash.now[:email] = params[:session][:email]
            render 'new'
        end
    end

    def new
        render 'new'
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end
end