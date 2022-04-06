module AuthFeaturesHelper
    def log_in(user)
        visit new_session_url
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'Sign In'
    end
end