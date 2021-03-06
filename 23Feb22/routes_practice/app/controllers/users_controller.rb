class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user = User.new(user_params)

        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by_id(params[:id])

        if user
            render json: user
        else
            render plain: "User not found.", status: :not_found
        end
    end

    def update
        user = User.find_by_id(params[:id])

        if !user
            render plain: "User not found.", status: :not_found
        elsif user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find_by_id(params[:id])

        if !user
            render plain: "User not found.", status: :not_found
        elsif user.destroy
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params[:user].permit(:name, :email)
    end
end