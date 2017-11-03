# frozen_string_literal: true

require "rails_helper"

describe User::Create do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:original_params) { { email: "test@gmail.com", password: "pwd" } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }

  context "input validation" do
    context "email field" do
      context "is missing" do
        let(:params) { original_params.except(:email) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(email: "") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end

      context "is not an email format" do
        let(:params) { original_params.merge(email: "non_email") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:email]).to be_present
        end
      end
    end

    context "password field" do
      context "is empty" do
        let(:params) { original_params.merge(password: "") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:password]).to be_present
        end
      end

      context "is missing" do
        let(:params) { original_params.except(:password) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:password]).to be_present
        end
      end
    end
  end

  context "authorization" do
    let(:current_user) { create :user }

    specify 'should not be authorized' do
      result = described_class.call(params, options, options)
      expect(result.success?).to be_falsy
    end
  end

  context "positive case" do
    specify "a new user is created" do
      options
      expect do
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"]).to be_a(User)
        expect(result["model"]).to be_persisted
        expect(result["model"].valid_password?(params[:password])).to be_truthy
      end.to change { User.count }.by(1)
    end
  end

  #TODO check for the regular user...
end
