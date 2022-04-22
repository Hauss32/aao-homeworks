class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :log_in_user, :log_out_user, :current_user

    def log_in_user(user)
        token = user.reset_session_token!
        session[:session_token] = token
        redirect_to root_url
    end

    def log_out_user(user)
        user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

    private
    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
