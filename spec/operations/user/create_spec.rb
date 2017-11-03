# frozen_string_literal: true

require "rails_helper"

describe User::Create do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:original_params) { { email: "test@gmail.com", password: "pwd", current_user: current_user } }
  let(:params) { original_params }

  context "input validation" do
    context "email field" do
      context "is missing" do
        let(:params) { original_params.except(:email) }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(email: "") }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end

      context "is not an email format" do
        let(:params) { original_params.merge(email: "non_email") }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end
    end

    context "password field" do
      context "is emptty" do
        let(:params) { original_params.merge(password: "") }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:password]).to be_present
        end
      end

      context "is missing" do
        let(:params) { original_params.except(:password) }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:password]).to be_present
        end
      end
    end
  end

  context "positive case" do
    specify "a new user is created" do
      params
      expect do
        result = described_class.call(params)
        expect(result.success?).to be_truthy
      end.to change { User.count }.by(1)
    end
  end

  #TODO check for the regular user...
end
