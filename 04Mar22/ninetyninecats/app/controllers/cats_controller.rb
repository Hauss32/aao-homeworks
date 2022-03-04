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
end