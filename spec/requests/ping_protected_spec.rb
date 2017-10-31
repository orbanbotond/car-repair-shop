require 'rails_helper'

describe 'GET /api/ping' do
  let(:headers) { authorization_header_for user }
  let(:path) { '/api/ping' }
  let(:headers) { auth_header_for(profile) }

  let(:expect_brokerage_endpoint) { false }
  let(:path) { '/v1/broker_profiles' }

  subject { get path }

  specify 'return json' do
    expect_success
    expect(response_json['ping']).to eq('pong')
  end

  specify 's1' do
    expect_success
  end
end
