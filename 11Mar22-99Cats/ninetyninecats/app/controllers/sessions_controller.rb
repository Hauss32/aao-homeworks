class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        puts '########################'
        puts params[:session][:username]
        puts params[:session][:password]
        puts '########################'
        user = User.find_by_credentials(
            params[:session][:username], 
            params[:session][:password])

        if !user
            render json: 'Invalid Credentials.', status: :unprocessable_entity
        else  
            user.reset_session_token!
            session[:session_token] = user.session_token
            redirect_to root_url
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