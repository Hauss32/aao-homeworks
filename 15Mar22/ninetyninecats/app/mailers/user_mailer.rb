class UserMailer < ApplicationMailer
    default from: 'everybody@appacademy.io'

    def welcome_email(user)
        @user = user
        mail(to: "#{user.username} <#{user.username}@email.com>", subject: 'Get Ready to Rent Some Cats!')
    end
end
