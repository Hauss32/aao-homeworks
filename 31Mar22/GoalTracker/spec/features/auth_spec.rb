require 'spec_helper'
require 'rails_helper'

feature 'user creation process' do
    scenario 'has a new user page' do 
        visit new_user_url
        expect(page).to have_content('Sign Up!')
    end

    feature 'creating a user' do
        scenario 'shows homepage after signup' do
            visit new_user_url
            fill_in 'email', with: 'test@test.test'
            fill_in 'password', with: 'password'
            click_on 'Create Account'
            expect(page).to have_content('Home Page')
        end
    end
end

feature 'sign in process' do
    scenario 'has a log in page' do
        visit new_session_url
        expect(page).to have_content('Sign In!')
    end

    feature 'logging in a user' do
        scenario 'shows homepage after logging in' do
            user = User.create!(email: 'test@test.test', password: 'password')
            visit new_session_url
            fill_in 'email', with: 'test@test.test'
            fill_in 'password', with: 'password'
            click_button 'Sign In'
            expect(page).to have_content('Home Page')
        end
    end
end

feature 'the sign out process' do
    scenario 'a signed in user signs out' do
        user = User.create!(email: 'test@test.test', password: 'password')
        visit new_session_url
        fill_in 'email', with: 'test@test.test'
        fill_in 'password', with: 'password'
        click_button 'Sign In'
        visit root_url
        click_on 'Log Out'
        expect(page).to have_content('Sign In')
    end
end