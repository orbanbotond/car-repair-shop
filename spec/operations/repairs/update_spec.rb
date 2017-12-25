# frozen_string_literal: true

require "rails_helper"

describe Repair::Update do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:repair) { create :repair, user: owner_user  }
  let(:owner_user) { create :user }
  let(:original_params) { { id: repair.id, name: 'New name for the repair'} }
  let(:params) { original_params }
  let(:options) { { "current_user" => current_user } }

  context 'negative cases' do
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

  context "authorization" do
    context 'admin_user' do
      # let(:current_user) { admin_user }

      # context 'tries to approve' do
      #   specify 'should not be authorized' do
      #     result = described_class.call(params.merge(approved: true), options)
      #     expect(result.success?).to be_truthy
      #   end
      # end

      # context 'tries to complete' do
      #   specify 'should be authorized' do
      #     result = described_class.call(params.merge(completed: true), options)
      #     expect(result.success?).to be_truthy
      #   end
      # end

      # context 'tries to uncomplete' do
      #   specify 'should not be authorized' do
      #     result = described_class.call(params.merge(completed: false), options)
      #     expect(result.success?).to be_truthy
      #   end
      # end
    end

    # context 'owner_user' do
    #   let(:current_user) { owner_user }

    #   context 'tries to complete' do
    #     specify 'should be authorized' do
    #       result = described_class.call(params, options)
    #       expect(result.success?).to be_truthy
    #     end
    #   end
    # end

    context 'non owner' do     
      let(:current_user) { create :user }

      specify 'should not be authorized' do
        result = described_class.call(params, options)
        expect(result.success?).to be_falsy
        expect(result['result.policy.default']['message']).to eq('Breach')
      end
    end
  end

  context "positive case" do
    context "changing the name" do
      specify "changed" do
        params
        result = described_class.call(params, options)
        expect(result.success?).to be_truthy
        expect(result["model"].reload.name).to eq(params[:name])
      end
    end
  end
end
