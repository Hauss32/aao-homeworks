class TracksController < ApplicationController
    before_action :require_user!

    def index
        album_id = params[:album_id]

        if album_id
            @tracks = Track.where(album_id: album_id)
        else
            @tracks = Track.all
        end

        render 'tracks'
    end

    def create
        @track = Track.new(track_params)

        if @track.save
            redirect_to track_url(@track)
        else
            @albums ||= Album.all
            render 'new'
        end

    end

    def new
        @albums = Album.all
        @track = Track.new
        @track.album_id = params[:album_id]

        render 'new'
    end

    def show
        @track = Track.find_by_id(params[:id])

        if @track
            render 'track'
        else
            render json: 'Track not found.', status: :not_found
        end
    end

    def update
        track = Track.find_by_id(params[:id])

        if track.nil?
            render json: 'Track not found.', status: :not_found
        elsif track.update(track_params)
            redirect_to track_url(track)
        else
            render json: track.errors.full_messages, status: :unprocessable_entity
        end
    end

    def edit
        @track = Track.find_by_id(params[:id])
        @albums = Album.all

        render 'edit'
    end

    def destroy
        track = Track.find_by_id(params[:id])
        track.destroy
        redirect_to tracks_url
    end

    private
    def track_params
        params[:track].permit(:title, :album_id, :ord, :is_bonus_track, :lyrics)
    end
end