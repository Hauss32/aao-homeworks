class RentalRequestsController < ApplicationController
    before_action :require_ownership, only: [:approve, :deny]
    before_action :require_user!

    def create
        new_request = RentalRequest.new(rental_request_params)
        new_request.user_id = current_user.id

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

    def require_ownership
        rental_cat = RentalRequest.find_by_id(params[:id]).cat
        is_owner = current_user.cats.include?(rental_cat)
        redirect_to cat_url(rental_cat) unless is_owner
    end
end