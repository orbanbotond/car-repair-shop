# frozen_string_literal: true

require "rails_helper"

describe User::Create do
  let(:admin_user) { create :admin_user }
  let(:current_user) { admin_user }
  let(:original_params) { { email: 'test@gmail.com', password: 'pwd', current_user: current_user } }
  let(:params) { original_params }

  context 'input validation' do
    context 'email is missing' do
      let(:params) { original_params.except(:email) }

      specify do
        result = User::Create.call(params)
        expect(result.success?).to be_falsy
        expect(result["result.error"]).to be_truthy
binding.pry
      end
    end
  end
end
