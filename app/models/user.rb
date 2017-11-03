# frozen_string_literal: true

class User < ApplicationRecord
  include BCrypt

  rolify

  has_many :repairs

  before_save :create_authentication_token

  def password=(new_password)
    return unless new_password

    @password = Password.create(new_password)
    self.hashed_pwd = @password
  end

  def password
    @password ||= Password.new(hashed_pwd)
  end

  def valid_password?(pwd)
    password == pwd
  end

  def create_authentication_token
    return if authentication_token.present?

    self.authentication_token = SecureRandom.hex(32)
  end
end
