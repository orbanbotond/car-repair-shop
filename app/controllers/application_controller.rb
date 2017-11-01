# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def force_authentication
    redirect_to login_path unless current_user.present?
  end

  def current_user
    warden.try(:user)
  end
  helper_method :current_user

  def warden
    request.env["warden"]
  end
end
