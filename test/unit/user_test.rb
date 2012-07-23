require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate should return nil if no login is given" do
    assert_nil User.authenticate(nil, nil)
  end

  test "authenticate returns user if exists" do
    u = User.create! :login => "a", :password_salt => "asdf", :password_verifier => "asdf"
    assert_equal u.reload, User.authenticate("a", "")
    u.destroy
  end
end
