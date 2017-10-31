module APIHelpers
  extend ActiveSupport::Concern

  def expect_success
    call_api_endpoint_just_once
    expect(response).to be_success
  end

  def response_json
    @response_json ||= begin
      call_api_endpoint_just_once
      JSON.parse(response.body)
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
