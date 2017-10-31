require 'rails_helper'

describe 'GET /api/ping' do
  let(:headers) { {} }
  let(:path) { '/api/ping' }

  subject { get path }

  specify 'return json' do
    expect_success
    expect(response_json['ping']).to eq('pong')
  end

  specify 's1' do
    expect_success
  end
end
