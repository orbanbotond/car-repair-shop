module APIHelpers
  extend ActiveSupport::Concern

  def authentication_header_for(user)
    { 'X-Authentication-Token' => user.authentication_token }
  end

  def authentication_token_wrong
    { 'X-Authentication-Token' => 'Wrong' }
  end

  def expect_success
    call_api_endpoint_just_once
    expect(response).to be_success
  end

  def expect_unauthorized
    call_api_endpoint_just_once
    expect(response.status).to eq(401)
  end

  def expect_json
    call_api_endpoint_just_once
    expect{JSON.parse(response.body)}.to_not raise_error
  end

  def response_json
    @response_json ||= begin
      call_api_endpoint_just_once
      JSON.parse(response.body).with_indifferent_access
    end
  end


  included do
    after(:each) do
      @called_already = nil
    end
  end

  def call_api_endpoint_just_once
    return if @called_already

    @called_already = true

    subject
  end
end
