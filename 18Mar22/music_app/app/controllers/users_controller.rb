class UsersController < ApplicationController
    before_action :require_no_user!, only: [:create, :new]

    def create
        @user = User.new
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]

        if @user.save
            session[:session_token] = @user.session_token
            send_activation_email
            redirect_to root_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render 'new'
        end
    end

    def new
        @user = User.new
        render 'new'
    end

    def activate
        user = User.find_by(activation_code: params[:activation_code])

        if user
            user.is_activated = true
            user.save
            redirect_to root_url
        else
            render json: 'Activation code not recognized.', status: :unprocessable_entity
        end
    end

    private
    def send_activation_email
        msg = UserMailer.activation_email(@user)
        msg.deliver_now
    end

end