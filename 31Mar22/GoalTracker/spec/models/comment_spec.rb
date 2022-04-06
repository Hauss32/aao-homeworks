require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(email: 'test@test.test', password: 'password') }
  let!(:comment) { create(:comment, commentable: user, user_id: user.id) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_uniqueness_of(:commentable_id).scoped_to(:commentable_type) }

end
