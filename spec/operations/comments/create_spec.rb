# frozen_string_literal: true

require "rails_helper"

describe Comment::Create do
  let(:admin_user) { create :admin_user }
  let(:repair_owner) { create :user }
  let(:current_user) { admin_user }
  let(:original_params) { { comment: "The new comment", repair_id: repair.id } }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }
  let(:repair) { create :repair, user: repair_owner }

  context "input validation" do
    context "repair_id field" do
      context "is missing" do
        let(:params) { original_params.except(:repair_id) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(repair_id: nil) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end

      context "is not a number" do
        let(:params) { original_params.merge(repair_id: "not a number") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["params.errors"]).to be_present
        end
      end
    end

    context "comment field" do
      context "is missing" do
        let(:params) { original_params.except(:comment) }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:comment]).to be_present
        end
      end

      context "is blank" do
        let(:params) { original_params.merge(comment: "") }

        specify do
          result = described_class.call(params, options)
          expect(result.success?).to be_falsy
          expect(result["contract.default"].errors[:comment]).to be_present
        end
      end
    end
  end

  context "authorization" do
    context 'for a user who is not an owner of the repair' do
      let(:current_user) { create :user }

      specify 'should be authorized' do
        result = described_class.call(params, options, options)
        expect(result.success?).to be_falsy
        expect(result['result.policy.default']['message']).to eq('Breach')
      end
    end

    context 'for the owner of the repair' do
      let(:current_user) { repair_owner }

      specify 'should be authorized' do
        result = described_class.call(params, options, options)
        expect(result.success?).to be_truthy
      end
    end
  end

  context "positive case" do
    specify "a new comment is created" do
      options
      expect do
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"]).to be_a(Comment)
        expect(result["model"]).to be_persisted
        expect(result["model"].repair).to eq(repair)
      end.to change { repair.comments.count }.by(1)
    end
  end
end
