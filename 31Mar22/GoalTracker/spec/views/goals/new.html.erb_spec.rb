require "rails_helper"

RSpec.describe "goals/new" do
    before(:each) { assign(:goal, Goal.new) }

    it 'renders with page context of creating a goal' do
        render
        expect(rendered).to match(/New Goal!/)
    end

    it 'has a form button related to creating a goal' do
        render
        expect(rendered).to match(/Create Goal/)
    end
end