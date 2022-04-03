require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    let(:user_1) { User.create(email: 'user_1@test.test', password: 'password')}
    let(:goal_1) { create(:goal, user_id: user_1.id) }

    describe 'GET #index' do
        before(:each) { allow(controller).to receive(:current_user) { user_1 } }

        it 'returns a 200 code' do
            @current_user = user_1
            get :index
            expect(response).to have_http_status(200)
        end

        it 'renders index page' do
            get :index

            expect(response).to render_template(:index)
        end
    end

    describe 'GET #new' do
        before(:each) { allow(controller).to receive(:current_user) { user_1 } }

        it 'renders new goal form' do 
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do 
        context 'with valid data' do
            before(:each) { allow(controller).to receive(:current_user) { user_1 } }

            it 'redirects to new goal record' do 
                post :create, params: { goal: {
                    title: 'Goalie Goal',
                    description: 'Save 1.5 goals in hockey'} }
                expect(response).to redirect_to(Goal.last)
            end
        end

        context 'with invalid data' do
            before(:each) { allow(controller).to receive(:current_user) { user_1 } }

            it 're-renders new page with errors' do
                post :create, params: { goal: {
                    title: '',
                    description: 'Save 1.5 goals in hockey'} }
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
    end

    describe 'GET #edit' do 
        it 'renders edit goal form' do 
            get :edit, params: { id: goal_1.id }
            expect(response).to render_template(:edit)
        end
    end

    describe 'PUT #update' do
        context 'with valid data' do
            it 'redirects to edited goal record' do
                patch :update, params: { id: goal_1.id, goal: {
                    is_complete: true
                } }
                expect(response).to redirect_to(goal_1)
            end 
        end

        context 'with invalid data' do
            it 're-renders edit page with errors' do
                patch :update, params: { id: goal_1.id, goal: {
                    title: ''
                } }
                expect(response).to render_template(:edit)
                expect(flash[:errors]).to be_present
            end
        end
    end

    describe 'GET #show' do
        it 'returns a 200 code' do 
            get :show, params: { id: goal_1.id }
            expect(response).to have_http_status(200)
        end

        it 'redirects to goal page' do
            get :show, params: { id: goal_1.id }
            expect(response).to render_template(:goal)
        end
    end

    describe 'DELETE #destroy' do 
        it 'deletes a goal record from the database' do
            delete :destroy, params: { id: goal_1.id }
            expect(Goal.find_by_id(goal_1.id)).to be_nil
        end

        it 'redirects to index page' do
            delete :destroy, params: { id: goal_1.id }
            expect(response).to redirect_to(goals_url)
        end
    end
end
