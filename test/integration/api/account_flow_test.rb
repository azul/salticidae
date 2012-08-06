require 'test_helper'

class AccountFlowTest < ActionDispatch::IntegrationTest

  def teardown
    @user.destroy if @user # make sure we can run this test again
  end

  test "signup and login with srp via api" do
    login = "integration_test_user"
    password = "srp, verify me!"
    srp = SRP::Client.new(login, password)
    post '/users.json', :user => {
      :login => login,
      :password_verifier => srp.verifier.to_s(16),
      :password_salt => srp.salt.to_s(16)
    }
    @user = User.find_by_param(login)
    assert_equal({:login => login, :password_salt => srp.salt.to_s(16)}.to_json, response.body)
    assert_response :success
    assert_equal login, @user.login
  end
end
