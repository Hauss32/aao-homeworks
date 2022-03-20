class BandsController < ApplicationController
    before_action :require_user!

    def index
        @bands = Band.all
        render 'bands'
    end

    def create
        band = Band.new(band_params)

        if band.save
            redirect_to band_url(band)
        else
            redirect_to new_band_url
        end

    end

    def new
        @band = Band.new
        render 'new'
    end

    def show
        @band = Band.find_by_id(params[:id])

        if @band
            render 'band'
        else
            render json: 'Band not found.', status: :not_found
        end
    end

    def update
        band = Band.find_by_id(params[:id])

        if band.nil?
            render json: 'Band not found.', status: :not_found
        elsif band.update(band_params)
            redirect_to band_url(band)
        else
            render json: band.errors.full_messages, status: :unprocessable_entity
        end
    end

    def edit
        @band = Band.find_by_id(params[:id])
        render 'edit'
    end

    def destroy
        band = Band.find_by_id(params[:id])
        band.destroy
        redirect_to bands_url
    end

    private
    def band_params
        params[:band].permit(:name)
    end
end