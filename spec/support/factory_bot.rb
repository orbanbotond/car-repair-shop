# frozen_string_literal: true

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # config.before(:suite) do
  #   FactoryBot.find_definitions
  # end
end
