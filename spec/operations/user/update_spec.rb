# frozen_string_literal: true

require "rails_helper"

describe User::Update do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:user) { create :user }
  let(:original_params) { { id: user.id, email: "another_email@gmail.com", password: "pwd", current_user: current_user } }
  let(:params) { original_params }

  context "input validation" do
    context "id field" do
      context "is missing" do
        let(:params) { original_params.except(:id) }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:id]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(id: nil) }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:id]).to be_present
        end
      end

      context "is not a number" do
        let(:params) { original_params.merge(id: "not a number") }

        specify do
          result = described_class.call(params)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:id]).to be_present
        end
      end
    end

    context "email field" do
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
    end
  end
  #TODO check for the regular user...

end
