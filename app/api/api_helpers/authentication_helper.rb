module ApiHelpers
  module AuthenticationHelper

    TOKEN_PARAM_NAME = 'X-Authentication-Token'

    def session_token(token_param = TOKEN_PARAM_NAME)
      headers[token_param]
    end

    def current_token
      session_token
    end

    def authorization_context_options
      {}
    end

    def current_user
      return nil unless session_token.present?
      user = user_from_token
      return nil unless user.present?
      @current_user ||= user
    end

    def signed_in?
      !!current_user
    end

    def authenticate!
      return if signed_in?

      error! '401 Unauthorized', 401
    end

  private

    def user_from_token
      User.find_by authentication_token: current_token
    end
  end
end
