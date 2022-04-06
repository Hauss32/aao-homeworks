class CommentsController < ApplicationController
    def create
        comment = Comment.new(comment_params)
        comment.user_id = current_user.id

        unless comment.save
            flash[:errors] = comment.errors.full_messages
        end
            
        redirect_back fallback_location: root_url
    end

    private
    def comment_params
        params[:comment].permit(:body, :commentable_id, :commentable_type)
    end
end
