require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) }
end
