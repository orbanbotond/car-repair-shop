# frozen_string_literal: true

require "rails_helper"

describe Repair::Update do
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }
  let(:current_user) { admin_user }
  let(:original_params) { { id: repair.id, name: "Repair New Name" } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }
  let(:repair) { create :repair }

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

    context "name field" do
      context "is missing" do
        let(:params) { original_params.except(:name) }

        specify do
          result = described_class.call(params, options)
          binding.pry
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

  context "authorization for non admin" do
    let(:current_user) { create :user }

    specify 'should not be authorized' do
      result = described_class.call(params, options)
      expect(result.success?).to be_falsy
      expect(result['result.policy.default']['message']).to eq('Breach')
    end
  end

  context "positive case" do
    context "changing the name" do
      specify "changed" do
        params
        expect do
          result = described_class.call(params, options)
          expect(result.success?).to be_truthy
          expect(result["model"]).to be_a(Repair)
          expect(result["model"].name).to eq(params[:name])
        end.to change { repair.reload.name }
      end
    end
  end
end
