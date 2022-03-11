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

    def approve
        req = RentalRequest.find_by_id(params[:id])

        if !req
            render json: "Rental Request not found.", status: :not_found
        elsif req.approve!
            redirect_to cat_url(req.cat_id)
        else
            render json: req.errors.full_messages, status: :unprocessable_entity
        end
    end

    def deny
        req = RentalRequest.find_by_id(params[:id])

        if !req
            render json: "Rental Request not found.", status: :not_found
        elsif req.deny!
            redirect_to cat_url(req.cat_id)
        else
            render json: req.errors.full_messages, status: :unprocessable_entity
        end
    end

    private
    def rental_request_params
        params[:rental_request].permit(:cat_id, :start_date, :end_date)
    end
end