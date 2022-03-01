class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            artist = User.find_by_id(params[:user_id])

            if artist
                # TODO: Consolidate into 1 query from User model method
                all_art = []
                all_art += artist.artworks
                all_art += artist.shared_artworks

                render json: all_art
            else
                render plain: 'User not found.', status: :not_found
            end
        else 
            render json: Artwork.all
        end
    end

    def create
        artwork = Artwork.new(artwork_params)

        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        artwork = Artwork.find_by_id(params[:id])

        if artwork
            render json: artwork
        else 
            render plain: 'Artwork not found.', status: :not_found
        end
    end

    def update
        artwork = Artwork.find_by_id(params[:id])

       if !artwork
            render plain: 'Artwork not found.', status: :not_found
       elsif artwork.update(artwork_params)
            render json: artwork
       else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
       end
    end

    def destroy
        artwork = Artwork.find_by_id(params[:id])

       if !artwork
            render plain: 'Artwork not found.', status: :not_found
       elsif artwork.destroy
            render json: artwork
       else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
       end 
    end

    def like
        like = Like.new(user_id: params[:user_id], likeable_id: params[:artwork_id], likeable_type: 'Artwork')

        if like.save
            render json: like
        else  
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    def unlike
        like = Like.find_by(user_id: params[:user_id], likeable_id: params[:artwork_id], likeable_type: 'Artwork')

        if !like
            render plain: 'Like not found.', status: :not_found
        elsif like.destroy
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    private
    def artwork_params
        params[:artwork].permit(:title, :image_url, :artist_id)
    end
    
end