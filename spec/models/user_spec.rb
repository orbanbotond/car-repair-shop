require 'rails_helper'

describe User do
  context 'fields' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:hashed_pwd) }
    it { is_expected.to respond_to(:authentication_token) }
  end

  context 'callbacks' do
    specify 'creates an authentication_token' do
      user = build :user
      user.save
      expect(user.reload.authentication_token).to be_present
    end
  end

  context 'rolification' do
    it { is_expected.to respond_to(:add_role) }
    it { is_expected.to respond_to(:has_role?) }
  end

  context 'methods' do
    context '#password=' do
      specify 'changes the hashed_pwd' do
        user = build :user
        expect { user.password = 'The another' }.to change { user.hashed_pwd }
      end
    end

    context 'valid_pwd?' do
      specify 'it is true for a valid pwd' do
        user = build :user 
        expect(user.valid_pwd? 'The Password').to be_truthy
      end

      specify 'it is false for a valid pwd' do
        user = build :user
        expect(user.valid_pwd? 'Invalid Password').to be_falsy
      end
    end
  end
end
