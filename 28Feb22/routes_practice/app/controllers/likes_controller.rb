class LikesController < ApplicationController
    def index
        if params[:user_id]
            user = User.find_by_id(params[:user_id])

            if !user
                render json: 'User not found.', status: :not_found
            else
                # TODO optimize to single query
                likes = user.comment_likes
                likes += user.artwork_likes

                render json: likes
            end
        elsif params[:comment_id]
            comment = Comment.find_by_id(params[:comment_id])

            if !comment
                render json: 'Comment not found.', status: :not_found
            else
                render json: comment.likes
            end
        elsif params[:artwork_id]
            artwork = Artwork.find_by_id(params[:artwork_id])

            if !artwork
                render json: 'Artwork not found.', status: :not_found
            else
                render json: artwork.likes
            end
        else
            render plain: 'User, Comment, or Artowrk not provided.', status: :unprocessable_entity
        end
    end
end