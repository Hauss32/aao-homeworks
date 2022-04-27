class CommentsController < ApplicationController
    before_action :require_logged_in_user!

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            if @comment.parent_comment_id.nil?
                redirect_to post_url(@comment.post_id)
            else
                redirect_to comment_url(@comment.parent_comment_id)
            end
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

    def show
        @comment = Comment.where(id: params[:id])
                        .joins(:author)
                        .joins(:post)
                        .select('comments.*, users.email, posts.title')
                        .first
        @all_comments = @comment.post.comments_by_parent_id
        render 'comment'
    end

    private
    def comment_params
        params[:comment].permit(:body, :post_id, :parent_comment_id)
    end
end
