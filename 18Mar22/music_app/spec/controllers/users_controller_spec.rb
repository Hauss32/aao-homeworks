require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET #new" do
        it "renders new form template" do
            get :new, {}
            expect(response).to render_template("new")
        end
    end

    describe "POST #create" do
        context "when User is invalid" do
            it "validates the presense of email" do
                post :create, params: { user: {password: 'password'} }

                expect(flash[:errors]).to be_present
                expect(response).to render_template("new")
            end

            it "validates the presense of password" do
                post :create, params: { user: {email: 'test@test.test', password: ''} }

                expect(flash[:errors]).to be_present
                expect(response).to render_template("new")
            end

            it "validates the password is at least 8 characters" do
                post :create, params: { user: {email: 'test@test.test', password: 'short'} }

                expect(flash[:errors]).to be_present
                expect(response).to render_template("new")
            end

        end

        context "when User is valid" do
            it "redirects to root url" do
                post :create, params: { user: {email: 'test@test.test', password: 'password'} }

                expect(response).to redirect_to(root_url)
            end
        end
    end
end
