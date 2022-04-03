require "rails_helper"

RSpec.describe "goals/goal" do
    let(:user_1) { User.create(email: 'user_1@test.test', password: 'password')}
    let(:goal_1) { create(:goal, user_id: user_1.id) }

    before(:each) { assign(:goal, goal_1) }

    it 'renders with the title of the goal' do
        render
        expect(rendered).to match(/#{goal_1.title}/)
    end

    it 'renders attributes about the goal' do
        render
        expect(rendered).to match(/#{goal_1.description}/)
    end
end