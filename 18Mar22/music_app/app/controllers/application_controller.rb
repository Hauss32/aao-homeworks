class ApplicationController < ActionController::Base
    helper_method :current_user, :log_in_user!, :require_activated_user!, :require_no_user!

    def log_in_user!
        if current_user
            session[:session_token] = current_user.reset_session_token!
            redirect_to root_url
        else
            redirect_to new_session_url
        end
    end

    def require_activated_user!
        redirect_to new_session_url unless current_user && current_user.is_activated
    end

    def require_no_user!
        render json: 'You are already logged in.', status: :forbidden if current_user
    end

    private
    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
