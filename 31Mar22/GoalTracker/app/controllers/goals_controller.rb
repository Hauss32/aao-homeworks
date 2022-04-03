class GoalsController < ApplicationController
    def index
        all_goals = Goal.where('user_id = ? OR is_public = true', current_user.id)
        @own_goals = all_goals.select { |goal| goal.user_id == current_user.id }
        @other_goals = all_goals.select { |goal| goal.user_id != current_user.id }
        render 'index'
    end

    def create
        @goal = Goal.new(goal_params)
        @goal.user_id = current_user.id

        if @goal.save
            redirect_to goal_url(@goal)
        else 
            flash.now[:errors] = @goal.errors.full_messages
            render 'new'
        end
    end

    def new
        @goal = Goal.new
        render 'new'
    end

    def update
        @goal = Goal.find_by_id(params[:id])
        
        if @goal.nil?
            render_not_found
        elsif @goal.update(goal_params)
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render 'edit'
        end    
    end

    def edit
        @goal = Goal.find_by_id(params[:id])
        
        if @goal.nil?
            render_not_found
        else
            render 'edit'
        end
    end

    def show
        @goal = Goal.find_by_id(params[:id])
        
        if @goal.nil?
            render_not_found
        else
            render 'goal'
        end 
    end

    def destroy
        @goal = Goal.find_by_id(params[:id])
        
        if @goal.nil?
            render_not_found
        elsif @goal.destroy
            redirect_to goals_url
        else
            render json: 'Unable to delete record.', status: :unprocessable_entity
        end
    end

    private
    def goal_params
        params[:goal].permit(:title, :description, :is_complete, :is_public)
    end
end
