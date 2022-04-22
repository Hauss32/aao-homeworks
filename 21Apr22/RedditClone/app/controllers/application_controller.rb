class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :log_in_user, :log_out_user, :current_user, 
    :require_logged_in_user!, :is_moderator!
  
    def log_in_user(user)
        token = user.reset_session_token!
        session[:session_token] = token

        if session[:referrer]
            redirect_to session[:referrer]
            session.delete(:referrer)
        else
            redirect_to root_url
        end
    end

    def log_out_user(user)
        user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

    def require_logged_in_user!
        unless current_user
            session[:referrer] = request.fullpath
            redirect_to new_session_url unless current_user
        end

        return
    end

    private
    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
