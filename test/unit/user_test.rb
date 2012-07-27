require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "test set of attributes should be valid" do
    user = User.new(attributes_for(:user))
    assert user.valid?
  end

  test "find_by_param gets User by login" do
    user = User.create!(attributes_for(:user))
    assert_equal user, User.find_by_param(user.login)
    user.destroy
  end

  test "to_param gives user login" do
    user = User.new(attributes_for(:user))
    assert_equal user.login, user.to_param
  end

  test "initialize_auth returns server handshake" do
    client_rnd = "a123"
    user = User.new(attributes_for(:user))
    srp_session = user.initialize_auth(client_rnd)
    assert srp_session.is_a? SRP::Authorization::Session
    assert_equal client_rnd, srp_session[:A]
  end

end
