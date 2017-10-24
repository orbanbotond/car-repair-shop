class User < ApplicationRecord
  def password=(pwd)
    self.hashed_pwd = BCrypt::Password.create(pwd)
  end

  def valid_pwd?(pwd)
    BCrypt::Password.new(self.hashed_pwd) == pwd
  end
end
