class CommentsController < ApplicationController
    before_action :require_logged_in_user!

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            redirect_to post_url(@comment.post_id)
        else
            flash.new[:errors] = @comment.errors.full_messages
            render 'new'
        end
    end

    def new
        @comment = Comment.new
        @comment.post_id = params[:id]
        render 'new'
    end

    private
    def comment_params
        params[:comment].permit(:body, :post_id)
    end
end
