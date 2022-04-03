require "rails_helper"

RSpec.describe "goals/index" do
    let(:user_1) { User.create(email: 'user_1@test.test', password: 'password')}
    let(:user_2) { User.create(email: 'user_2@test.test', password: 'password')}
    let(:goal_1) { create(:goal, user_id: user_1.id) }
    let(:goal_2) { create(:public_incomplete_goal, user_id: user_2.id) }

    
    before(:each) do
        assign(:own_goals, [goal_1])
        assign(:other_goals, [goal_2])
    end

    it 'renders goal links owned by logged-in user' do
        render
        expect(rendered).to have_link(goal_1.title, href: goal_url(goal_1))
    end

    it 'renders public goal links owned by other users' do
        render
        expect(rendered).to have_link(goal_2.title, href: goal_url(goal_2))
    end
end