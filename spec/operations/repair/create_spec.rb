# frozen_string_literal: true

require "rails_helper"

describe Repair::Create do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:original_params) { { name: "Tesla 3" } }
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
        let(:params) { original_params.merge(name: "") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:name]).to be_present
        end
      end
    end
  end

  context "authorization for non admin" do
    let(:current_user) { create :user }

    specify 'should not be authorized' do
      result = described_class.call(params, options, options)
      expect(result.success?).to be_falsy
      expect(result['result.policy.default']['message']).to eq('Breach')
    end
  end

  context "positive case" do
    specify "a new entity is created" do
      options
      expect do
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"]).to be_a(Repair)
        expect(result["model"]).to be_persisted
        expect(result["model"].name).to eq(params[:name])
        expect(result["model"].completed).to be_falsy
        expect(result["model"].approved).to be_falsy
      end.to change { Repair.count }.by(1)
    end
  end
end
