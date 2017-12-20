# frozen_string_literal: true

require "rails_helper"

# -Repair: MANAGER: CRUD , Complete, Uncomplete, Assign User, Approve, USER: Mark as Complete, List

describe Repair::Create do
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }
  let(:current_user) { admin_user }
  let(:original_params) { { name: "Repair 1" } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }

  context "input validation" do
    context "name field" do
      context "is missing" do
        let(:params) { original_params.except(:name) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:name]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(name: nil) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:name]).to be_present
        end
      end
    end
  end

  context "authorization" do
    context 'for a regular_user' do
      let(:current_user) { regular_user }

      specify 'should not be authorized' do
        result = described_class.call(params, options, options)
        expect(result.success?).to be_falsy
        expect(result['result.policy.default']['message']).to eq('Breach')
      end
    end
  end

  context "positive case" do
    specify "a new repair is created" do
      options
      expect do
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"]).to be_a(Repair)
        expect(result["model"]).to be_persisted
        expect(result["model"].name).to eq(params[:name])
      end.to change { Repair.count }.by(1)
    end
  end
end
