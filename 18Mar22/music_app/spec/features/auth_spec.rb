require 'rails_helper'

feature "account creation" do
    scenario "has a user signup page" do
        visit new_user_url
        expect(page).to have_content('Sign Up!')
    end

    feature "user signup form" do
        before(:each) do 
            visit new_user_url
            fill_in 'email', with: 'test@test.test'
        end

        scenario "with invalid inputs" do
            fill_in 'password', with: ''
            click_on 'Create Account'
            expect(page).to have_content('Sign Up!')
            expect(page).to have_content("Password is too short (minimum is 8 characters)")
        end
        
        scenario "with valid inputs" do
            fill_in 'password', with: 'password'
            click_on 'Create Account'

            expect(page).to have_content("Welcome to MusicApp")
        end
    end

end