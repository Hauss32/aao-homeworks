class UserMailer < ApplicationMailer
    default from: "MusicApp <hello@musicapp.test>"

    def activation_email(user)
        @user = user
        @url = "#{activate_users_url}?activation_code=#{@user.activation_code}"
        mail(to: user.email, subject: 'Get Started with MusicApp')
    end
end
