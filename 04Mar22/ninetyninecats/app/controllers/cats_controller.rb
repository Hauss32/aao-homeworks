class CatsController < ApplicationController
    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by_id(params[:id])
        render :cat
    end

    def update
        render plain: 'No update action yet.'
    end

    def edit
        render plain: 'No edit action yet.'
    end

    def new
        render plain: 'No new action yet.'
    end

    def destroy
        render plain: 'No destroy action yet.'
    end
end