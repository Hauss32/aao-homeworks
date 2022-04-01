require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'POST #create' do
        context 'with valid form data' do
            it 'redirects to landing page' do
                post :create, params: { user: {email: 'test@test.test', password: 'password'} }
                expect(response).to redirect_to(root_url)
            end
            
        end

        context 'with invalid form data' do 
            it 're-renders the new termplate with errors' do
                post :create, params: { user: {email: 'test@test.test', password: ''} }
                expect(response).to render_template('new')
                expect(falsh[:errors]).to be_present
            end
        end
    end

    describe 'GET #new' do
        it 'renders the new user template' do
            get :new
            expect(response).to have_http_status(200)
            expect(response).to render_template('new')
        end
    end
end
