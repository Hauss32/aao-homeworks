require 'spec_helper'
require 'rails_helper'
require_relative '../support/auth_features_helper'

include GoalFeaturesHelper

feature 'CRUD for Goal objects' do
    given(:user_1) { User.create(email: 'test@test.test', password: 'password') }
    given(:user_2) { User.create(email: 'test_2@test.test', password: 'password') }
    given(:goal_1) { Goal.create(title: 'Make Goal', description: 'At least 2.', user_id: user_1.id) }

    feature 'creating a goal' do
        background(:each) { log_in(user_1) }

        scenario 'has a new goal page' do
            visit new_goal_url
            expect(page).to have_content('Create a New Goal!')
        end

        scenario 'shows new goal after creation' do
            visit new_goal_url
            fill_in 'title', with: 'Win 18 Gold Medals'
            fill_in 'description', with: 'This will help my imposter syndrome.'
            click_on 'Create Goal'
            expect(page).to have_content('Win 18 Gold Medals')
        end
    end

    feature 'editing a goal' do
        background(:each) { log_in(user_1) }

        scenario 'has an edit goal page' do 
            visit edit_goal_url(goal_1)
            expect(page).to have_content('Update Goal')
        end

        scenario 'goal updates with saved values' do
            visit edit_goal_url(goal_1)
            fill_in 'description', with: 'Just 1 goal.'
            click_on 'Save'
            expect(page).to have_content('Just 1 goal.')
        end

        scenario 'goal can be completed from edit form' do
            visit edit_goal_url(goal_1)
            select 'Yes', from: 'is_complete'
            click_on 'Save'
            expect(page).to have_content('Goal Completed!')
        end
    end

    feature 'viewing a goal' do
        background(:each) { log_in(user_1) }

        scenario 'shows details from a goal' do 
            visit goal_url(goal_1)
            expect(page).to have_content(goal_1.title)
            expect(page).to have_content(goal_1.description)
        end
    end

    feature 'index page shows all available goals' do
        background(:each) { log_in(user_1) }

        scenario 'shows goal related to logged-in user' do 
            visit goals_url
            save_and_open_page
            expect(page).to have_content(goal_1.title)
        end

        scenario 'shows public goal from other user' do
            pub_goal = create(:public_incomplete_goal, user_id: user_2.id)
            visit goals_url
            expect(page).to have_content(pub_goal.title)
        end

        scenario 'does not show private goals from other users' do
            priv_goal = create(:private_complete_goal, user_id: user_2.id)
            visit goals_url
            expect(page).to_not have_content(priv_goal.title)
        end
    end
end