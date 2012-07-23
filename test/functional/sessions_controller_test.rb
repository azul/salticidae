require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get login screen" do
    get :new
    assert_response :success
  end

  test "should reload login screen on empty login" do
    post :create
    assert_response :redirect
    assert_redirected_to log_in_url
  end

  test "should be able to login" do
    u = User.create! :login => "a", :password_salt => "asdf", :password_verifier => "asdf"
    post :create, :login => u.login
    assert_response :redirect
    assert_redirected_to root_url
    u.destroy
  end
end
