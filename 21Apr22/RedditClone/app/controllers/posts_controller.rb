class PostsController < ApplicationController
    before_action :require_logged_in_user!
    before_action :require_ownership!, only: [:edit, :update]

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id

        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render 'new'
        end
    end

    def new
        @post = Post.new
        @post.sub_id = params[:id]
        render 'new'
    end

    def show
        @post = Post.joins(:author)
            .where(id: params[:id])
            .select('posts.*, email')
            .first
        render 'post'
    end

    def update
        @post = Post.find_by_id(params[:id])
        
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render 'edit'
        end
    end

    def edit
        @post = Post.find_by_id(params[:id])
        render 'edit' 
    end

    def destroy
        post = Post.find_by_id(params[:id])
        return unless post
        sub_id = post.sub_id
        post.destroy
        redirect_to sub_url(sub_id)
    end

    private
    def post_params
        params[:post].permit(:title, :body, :url, :sub_id)
    end

    def require_ownership!
        return unless params[:id]
        @post = Post.find_by_id(params[:id])

        unless  @post.user_id == current_user.id
            render json: "You don't have access to modify this Post."
        end
    end
end
