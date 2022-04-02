require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'goal_keeper@goaltracker.test', password: 'password') }

  describe 'data validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:activation_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should have_many(:goals) }
  end

  describe 'associations' do
    # stub for future associations
  end

  describe '#password=' do
    it 'updates password to new value' do
      pw = subject.password
      subject.password = 'new_password'
      expect(subject.password).to_not eq(pw)
    end
  end

  describe '#correct_password?' do
    it 'should return true when password matches' do
      expect(subject.correct_password?('password')).to be(true)
    end

    it 'should return false when password does not match' do
      expect(subject.correct_password?('not_password')).to be(false)
    end
  end

  describe '#reset_session_token!' do
    it 'sets a new session token on the User' do
      old_token = subject.session_token
      subject.reset_session_token!
      expect(subject.session_token).to_not eq(old_token)
    end
  end

  describe '::find_by_credentials' do
    it 'returns a User with matching credentials' do
      subject.save!
      expect(User.find_by_credentials(subject.email, subject.password)).to eq(subject)
    end

    it 'returns nil when provided no matching credentials' do
      subject.save!
      expect(User.find_by_credentials(subject.email, 'bad_password')).to be_nil
    end
  end
end
