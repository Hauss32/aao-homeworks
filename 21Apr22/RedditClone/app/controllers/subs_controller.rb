class SubsController < ApplicationController
    before_action :require_logged_in_user!
    before_action :require_moderator!, only: [:edit, :update]
    
    def index
        @subs = Sub.limit(10)
        render 'index'
    end
    
    def create
        @sub = Sub.new(sub_params)
        @sub.user_id = current_user.id

        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render 'new'
        end
    end

    def new
        @sub = Sub.new
        render 'new'
    end

    def show
        @sub = Sub.joins(:moderator)
                .where(id: params[:id])
                .select('subs.*, email')
                .first
        render 'sub'
    end

    def update
        @sub ||= Sub.find_by_id(params[:id])
        return unless is_moderator!(@sub.user_id)

        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render 'edit'
        end
    end

    def edit
        @sub ||= Sub.find_by_id(params[:id])
        return unless is_moderator!(@sub.user_id)

        render 'edit'
    end

    private
    def sub_params
        params[:sub].permit(:title, :description)
    end

    def require_moderator!
        return unless params[:id]
        @sub = Sub.find_by_id(params[:id])

        unless  @sub.user_id == current_user.id
            render json: "You don't have access to modify this Sub."
        end
    end


end
