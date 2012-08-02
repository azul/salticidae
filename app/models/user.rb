class User < CouchRest::Model::Base

  include SRP::Authentication

  property :login, String
  property :email, String
  property :password_verifier, String
  property :password_salt, String

  validates :login, :password_salt, :password_verifier, :presence => true
  validates :login, :uniqueness => true

  timestamps!

  design do
    view :by_login
  end

  class << self
    alias_method :find_by_param, :find_by_login
  end

  def to_param
    self.login
  end

  def salt
    password_salt.hex
  end

  def verifier
    password_verifier.hex
  end
end
