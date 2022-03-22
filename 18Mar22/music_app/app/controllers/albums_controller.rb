class AlbumsController < ApplicationController
    before_action :require_user!

    def index
        band_id = params[:band_id]

        if band_id
            @albums = Album.where(band_id: band_id)
        else
            @albums = Album.all
        end

        render 'albums'
    end

    def create
        album = Album.new(album_params)

        if album.save
            redirect_to album_url(album)
        else
            @bands ||= Band.all
            render 'new'
        end

    end

    def new
        @bands = Band.all
        @album = Album.new
        @album.band_id = params[:band_id]

        render 'new'
    end

    def show
        @album = Album.find_by_id(params[:id])

        if @album
            render 'album'
        else
            render json: 'Album not found.', status: :not_found
        end
    end

    def update
        album = Album.find_by_id(params[:id])

        if album.nil?
            render json: 'Album not found.', status: :not_found
        elsif album.update(album_params)
            redirect_to album_url(album)
        else
            render json: album.errors.full_messages, status: :unprocessable_entity
        end
    end

    def edit
        @album = Album.find_by_id(params[:id])
        @bands = Band.all

        render 'edit'
    end

    def destroy
        album = Album.find_by_id(params[:id])
        album.destroy
        redirect_to albums_url
    end

    private
    def album_params
        params[:album].permit(:title, :band_id, :year, :is_live_album)
    end
end