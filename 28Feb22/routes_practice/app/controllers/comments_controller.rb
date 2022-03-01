class CommentsController < ApplicationController
    def index
        if params[:user_id]
            user = User.find_by_id(params[:user_id])

            if !user
                render plain: "User not found.", status: :not_found
            else
                render json: user.comments
            end
        elsif params[:artwork_id]
            artwork = Artwork.find_by_id(params[:artwork_id])

            if !artwork
                render plain: "Artwork not found.", status: :not_found
            else
                render json: artwork.comments
            end
        else
            render json: Comment.all
        end
        
    end

    def create
        comment = Comment.new(comment_params)

        if comment.save
            render json: comment
        else  
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end    
    end

    def destroy
        comment = Comment.find_by_id(params[:id])

        if !comment
            render plain: "Comment not found.", status: :not_found
        elsif comment.destroy 
            render json: comment
        else  
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def like
        like = Like.new(user_id: params[:user_id], likeable_id: params[:comment_id], likeable_type: 'Comment')

        if like.save
            render json: like
        else  
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    def unlike
        like = Like.find_by(user_id: params[:user_id], likeable_id: params[:comment_id], likeable_type: 'Comment')

        if !like
            render plain: 'Like not found.', status: :not_found
        elsif like.destroy
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    private
    def comment_params
        params[:comment].permit(:author_id, :artwork_id, :body)
    end

end