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

    private
     def artwork_share_params
        params[:artwork_share].permit(:artwork_id, :viewer_id)
     end
end