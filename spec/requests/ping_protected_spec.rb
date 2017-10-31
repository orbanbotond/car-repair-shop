require 'rails_helper'

describe 'GET /api/ping' do
  let(:user) { create :user }
  let(:headers) { authentication_header_for user }
  let(:params) { {} }
  let(:path) { '/api/ping_protected' }

  subject { get path, params: params, headers: headers }

  specify 'return json' do
    expect_success
    expect(response_json['ping']).to eq('pong')
  end

  context 'invalid token' do
    let(:headers) { authentication_token_wrong }

    specify 'will be unauthorized...' do
      expect_unauthorized
      expect_json
    end
  end

  context 'echo' do
    let(:params) { {pong: 'Cseva'} }

    specify 'will echo the input param' do
      expect_success
      expect(response_json[:ping]).to eq('Cseva')
    end
  end

end
