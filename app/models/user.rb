class User < ApplicationRecord

  before_save :create_authentication_token

  def password=(pwd)
    self.hashed_pwd = BCrypt::Password.create(pwd)
  end

  def valid_pwd?(pwd)
    BCrypt::Password.new(self.hashed_pwd) == pwd
  end

  def create_authentication_token
    return if authentication_token.present?

    self.authentication_token = SecureRandom.hex(32)
  end
end
