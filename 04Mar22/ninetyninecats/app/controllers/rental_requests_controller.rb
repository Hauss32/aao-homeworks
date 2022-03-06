class RentalRequestsController < ApplicationController
    def create
        new_request = RentalRequest.new(rental_request_params)

        if new_request.save
            redirect_to cat_url(params[:rental_request][:cat_id])
        else
            render json: new_request.errors.full_messages, status: :unprocessable_entity
        end
    end

    def new
        @cats = Cat.all
        render :new
    end

    private
    def rental_request_params
        params[:rental_request].permit(:cat_id, :start_date, :end_date)
    end
end