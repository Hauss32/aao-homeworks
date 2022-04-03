require "rails_helper"

RSpec.describe "goals/edit" do
    let(:user_1) { User.create(email: 'user_1@test.test', password: 'password')}
    let(:goal_1) { create(:goal, user_id: user_1.id) }

    before(:each) { assign(:goal, goal_1) }

    it 'renders with page context of updating a goal' do
        render
        expect(rendered).to match(/Update Goal/)
    end

    it 'has a form button related to saving changes' do
        render
        expect(rendered).to match(/Save/)
    end

    it 'contains pre-filled form values from existing goal' do
        render
        expect(rendered).to match(/#{goal_1.title}/)
    end
end