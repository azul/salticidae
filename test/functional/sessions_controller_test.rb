require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get login screen" do
    get :new
    assert_response :success
  end

  test "should reload login screen on failed login" do
    user = stub :login => "me", :id => 123
    User.expects(:authenticate).with(user.login, "").returns(nil)
    post :create, :login => user.login
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to log_in_url
  end

  test "should be able to login" do
    user = stub :login => "me", :id => 123
    User.expects(:authenticate).with(user.login, "").returns(user)
    post :create, :login => user.login
    assert_equal user.id, session[:user_id]
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "logout should reset sessions user_id" do
    session[:user_id] = "set"
    delete :destroy
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to root_url
  end

end
