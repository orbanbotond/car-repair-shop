# frozen_string_literal: true

require "rails_helper"

describe User::Update do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:user) { create :user }
  let(:original_params) { { id: user.id, email: "another_email@gmail.com" } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }

  context "input validation" do
    context "id field" do
      context "is missing" do
        let(:params) { original_params.except(:id) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(id: nil) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end

      context "is not a number" do
        let(:params) { original_params.merge(id: "not a number") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end
    end

    context "email field" do
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
  end

  context "authorization" do
    let(:current_user) { create :user }

    specify 'should not be authorized' do
      result = described_class.call(params, options)
      expect(result.success?).to be_falsy
    end
  end

  context "positive case" do
    context "changing the email" do
      specify "changed" do
        params
        expect(user.valid_password? attributes_for(:user)[:password]).to be_truthy
        expect do
          result = described_class.call(params, options)
          binding.pry
          expect(result.success?).to be_truthy
          expect(result["model"]).to be_a(User)
          expect(result["model"].valid_password? attributes_for(:user)[:password]).to be_truthy
        end.to change { user.reload.email }
      end
    end

    context 'changing the password' do
      let(:params) { original_params.merge( password: 'new password' ) }

      specify "changed" do
        params
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result['model']).to be_a(User)
        binding.pry
        expect(result['model'].valid_password? params[:password]).to be_truthy
      end
    end
  end
end
