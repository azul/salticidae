class User < CouchRest::Model::Base

  include SRP::Authentication

  property :login, String, :accessible => true
  property :email, String, :accessible => true
  property :password_verifier, String, :accessible => true
  property :password_salt, String, :accessible => true

  validates :login, :password_salt, :password_verifier, :presence => true
  validates :login, :uniqueness => true

  timestamps!

  design do
    view :by_login
  end

  class << self
    def find_by_param(login)
      return find_by_login(login) || raise(RECORD_NOT_FOUND)
    end
  end

  def to_param
    self.login
  end

  def to_json(options={})
    super(options.merge(:only => ['login', 'password_salt']))
  end

  def salt
    password_salt.hex
  end

  def verifier
    password_verifier.hex
  end

end
