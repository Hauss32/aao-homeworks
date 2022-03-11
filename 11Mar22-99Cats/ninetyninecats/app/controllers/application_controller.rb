class ApplicationController < ActionController::Base
    helper_method :current_user

    private

    def current_user
        return nil unless session[:session_token]
        user ||= User.find_by(session_token: session[:session_token])
    end
end
