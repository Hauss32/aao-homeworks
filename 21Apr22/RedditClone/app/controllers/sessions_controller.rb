class SessionsController < ApplicationController
    def create
        user = User.find_by_creds(params[:email], params[:password])

        if user
            log_in_user(user)
        else
            @email = params[:email]
            flash.now[:errors] = ['Incorrect email/password. Please try again.']
            render 'new'
        end
    end

    def new
        render 'new'
    end

    def destroy
        log_out_user
    end
end
