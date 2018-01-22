# frozen_string_literal: true

require "rails_helper"

describe User::Destroy do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:user) { create :user }
  let(:original_params) { { id: user.id } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }

  context "negative cases" do
    specify "admin can not destroy himself" do
      result = described_class.call(params.merge(id: current_user.id), options)
      expect(result.success?).to be_falsy
      expect(result["result.policy.default"]["message"]).to eq("Breach")
    end

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
    end
  end

  context "authorization for non admin user" do
    let(:current_user) { create :user }

    specify "should not be authorized" do
      result = described_class.call(params, options)
      expect(result.success?).to be_falsy
      expect(result["result.policy.default"]["message"]).to eq("Breach")
    end
  end

  context "positive case" do
    specify "removes the user" do
      params
      options
      expect do
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"]).to be_a(User)
        expect(result["model"]).to be_destroyed
      end.to change { User.count }.by(-1)
    end
  end
end
