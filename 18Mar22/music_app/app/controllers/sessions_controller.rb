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
            redirect_to new_session_url
        end
    end

    def new
        render 'new_session'
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end
end