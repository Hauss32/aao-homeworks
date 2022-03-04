class CatsController < ApplicationController
    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by_id(params[:id])
        render :cat
    end

    def create
        new_cat = Cat.new(cat_params)

        if new_cat.save
            redirect_to cat_url(new_cat)
        else
            render json: new_cat.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        render plain: 'No update action yet.'
    end

    def edit
        render plain: 'No edit action yet.'
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
end