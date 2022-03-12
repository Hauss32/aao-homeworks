class CatsController < ApplicationController
    before_action :require_ownership, only: [:edit, :update]

    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by_id(params[:id])
        @is_owner = is_owner?
        @rental_requests = @cat.rental_requests.includes(:requester).order(:start_date)
        render :cat
    end

    def create
        new_cat = Cat.new(cat_params)
        new_cat.user_id = current_user.id

        if new_cat.save
            redirect_to cat_url(new_cat)
        else
            render json: new_cat.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        @cat = Cat.find_by_id(params[:id])

        if !@cat
            render json: "Cat not found.", status: :not_found
        elsif @cat.update(cat_params)
            redirect_to cat_url(@cat)
        else
            render json: @cat.errors.full_messages, status: :unprocessable_entity
        end   
    end

    def edit
        @cat = Cat.find_by_id(params[:id])

        if !@cat
            render json: "Cat not found.", status: :not_found
        else 
            render :edit
        end
    end

    def new
        render :new
    end

    def destroy
        render plain: 'No destroy action yet.'
    end

    private
    def cat_params
        params[:cat].permit(:name, :sex, :color, :birth_date, :description)
    end

    def is_owner?
        current_user.cats.include?(Cat.find_by_id(params[:id]))
    end

    def require_ownership
        redirect_to cat_url(params[:id]) unless is_owner?
    end
end