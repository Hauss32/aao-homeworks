class SessionsController < ApplicationController
    before_action :require_no_user!, only: [:new, :create]

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:session][:username], 
            params[:session][:password])

        if !user
            render json: 'Invalid Credentials.', status: :unprocessable_entity
        else  
            session[:session_token] = user.session_token
            login_user!
        end

    end

    def destroy
        if current_user
            current_user.reset_session_token!
            session[:session_token] = nil
            redirect_to new_session_url
        end

    end

    private

end
