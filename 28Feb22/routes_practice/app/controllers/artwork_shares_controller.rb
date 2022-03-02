class ArtworkSharesController < ApplicationController
    def create
        share = ArtworkShare.new(artwork_share_params)

        if share.save
            render json: share
        else 
            render json: share.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        share = ArtworkShare.find_by_id(params[:id])

       if !share
            render plain: 'Artwork Share not found.', status: :not_found
       elsif share.destroy 
            render json: share
       else
            render json: share.errors.full_messages, status: :unprocessable_entity
       end
    end

    def favorite
        share = ArtworkShare.find_by_id(params[:artwork_share_id])

        if !share
            render plain: 'Artwork Share not found.', status: :not_found
        elsif params[:user_id] != share.viewer_id.to_s
            render plain: 'Artwork Shares can only be favorited by viewer.', status: :unprocessable_entity
        else
            share.update(favorite: true)
            render json: share
        end
    end

    def unfavorite
        share = ArtworkShare.find_by_id(params[:artwork_share_id])

        if !share
            render plain: 'Artwork Share not found.', status: :not_found
        elsif params[:user_id] != share.viewer_id.to_s
            render plain: 'Artwork Shares can only be favorited by viewer.', status: :unprocessable_entity
        else
            share.update(favorite: false)
            render json: share
        end
    end

    private
     def artwork_share_params
        params[:artwork_share].permit(:artwork_id, :viewer_id)
     end
end