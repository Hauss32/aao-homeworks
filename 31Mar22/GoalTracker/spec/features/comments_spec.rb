require 'spec_helper'
require 'rails_helper'
require_relative '../support/auth_features_helper'

include AuthFeaturesHelper

feature 'Creating comments' do
    given(:user_1) { User.create(email: 'test@test.test', password: 'password') }
    given(:goal_1) { create(:goal, user_id: user_1) }
    given(:user_comment) { create(:comment, commentable: user_1) }
    given(:goal_comment) { create(:comment, commentable: goal_1) }

    shared_examples 'new comment' do
        background(:each) do 
            log_in(user_1)
            visit user_url(user_1)
        end

        scenario 'it has comment form' do
            expect(page).to have_content('New Comment')
            expect(page).to have_content('Post Comment')
        end

        scenario 'it shows comment when saved' do
            fill_in 'comment', with: 'Much comment! Many wow!'
            click_on 'Post Comment'
            expect(page).to have_content('Much comment! Many wow!')
        end
    end

    feature 'commeting on a user' do
        it_behaves_like 'new comment'
    end

    feature 'commeting on a goal' do
        background(:each) { visit goal_url(goal_1) }

        it_behaves_like 'new comment'
    end
end