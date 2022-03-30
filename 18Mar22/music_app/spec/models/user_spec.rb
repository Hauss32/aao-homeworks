require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(email: 'some_email@test.test', password: 'password') }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(8) }

  describe '#correct_password?' do
    it 'returns true when password is correct' do
      expect(subject.correct_password?('password')).to be(true)
    end

    it 'returns false when password is incorrect' do
      expect(subject.correct_password?('not_password')).to be(false)
    end
  end

  describe '#reset_session_token!' do
    it 'updates the session token of a User' do
      curr_token = subject.session_token
      subject.reset_session_token!
      expect(subject.session_token).to_not eq(curr_token)
    end
  end

  describe '::find_by_credentials' do
    it 'returns the user with matching credentials' do
      expect(User.find_by_credentials(subject.email, subject.password)).to eq(subject)
    end
  end
end
