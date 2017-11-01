# frozen_string_literal: true

module Common
  class PingProtected < Grape::API
    helpers ApiHelpers::AuthenticationHelper

    format :json

    before { authenticate! }

    desc "Returns pong."
    params do
      optional :pong, type: String
    end
    get :ping_protected do
      { ping: params[:pong] || "pong" }
    end
  end
end
