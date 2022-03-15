class ApplicationController < ActionController::Base
    helper_method :current_user

    def login_user!
        # user = User.find_by_credentials(
        #     params[:session][:username], 
        #     params[:session][:password])
        if !current_user
            redirect_to new_session_url
        else  
            session[:session_token] = current_user.reset_session_token!
            redirect_to root_url
        end
    end

    def require_no_user!
        redirect_to root_url if current_user
    end

    def require_user!
        redirect_to new_session_url unless current_user
    end
    
    private
    def current_user
        return nil unless session[:session_token]
        user ||= User.find_by(session_token: session[:session_token])
    end
end
