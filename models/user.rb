require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :login
  attr_accessor :password

  before_save :encrypt_password

  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def encrypt_password 
    self.password_salt = BCrypt::Engine.generate_salt 
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end