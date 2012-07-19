class User < CouchRest::Model::Base

  property :login, String
  property :email, String
  property :password_verifier, String
  property :password_salt, String

  timestamps!

  design do
    view :by_login
  end

end
