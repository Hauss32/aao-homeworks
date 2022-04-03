class ApplicationController < ActionController::Base
    helper_method :current_user, :log_in_user!, :log_out_user!

    def render_not_found
        render file: "#{Rails.root}/public/404.html",  :status => 404
    end
    
    def log_in_user!(user)
        user.reset_session_token!
        redirect_to root_url
    end

    def log_out_user!
        if current_user
            current_user.reset_session_token!
            session[:session_token] = nil
            redirect_to new_session_url
        else
            redirect_to new_session_url
        end
    end

    private
    def current_user
        return nil unless session[:session_token]

        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
