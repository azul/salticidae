require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @client_rnd = 'a123'
    @server_rnd = 'b123'
    @server_rnd_exp = 'e123'
    @server_handshake = {:A => @client_rnd, :B => @server_rnd, :b => @server_rnd_exp}
  end

  test "should get login screen" do
    get :new
    assert_response :success
  end

  test "should perform handshake" do
    user = stub :login => "me", :id => 123
    user.expects(:initialize_auth).
      with(@client_rnd).
      returns(@server_handshake)
    User.expects(:find_by_param).with(user.login).returns(user)
    post :create, :login => user.login, 'A' => @client_rnd
    assert_equal @server_handshake, session[:handshake]
    assert_response :success
    assert_equal @server_handshake.slice(:B).to_json, @response.body
  end

  test "should report user not found" do
    unknown = "login_that_does_not_exist"
    error = {:error => "unknown user", :field => "login"}
    User.expects(:find_by_param).with(unknown).raises(RECORD_NOT_FOUND)
    post :create, :login => unknown
    assert_response :success
    assert_equal error.to_json, @response.body
  end

  test "should authorize" do
    session[:handshake] = @server_handshake
    user = stub :login => "me", :id => 123
    user.expects(:authenticate!).
      with(@client_rnd, @server_handshake).
      returns(@server_auth)
    User.expects(:find_by_param).with(user.login).returns(user)
    post :update, :id => user.login, :client_auth => @client_rnd
    assert_nil session[:handshake]
    assert_equal @server_auth.to_json, @response.body
    assert_equal user.id, session[:user_id]
  end

  test "should report wrong password" do
    error = {:error => "wrong password", :field => "password"}
    session[:handshake] = @server_handshake
    user = stub :login => "me", :id => 123
    user.expects(:authenticate!).
      with(@client_auth, @server_handshake).
      raises(WRONG_PASSWORD)
    User.expects(:find_by_param).with(user.login).returns(user)
    post :update, :id => user.login, :client_auth => @client_auth
    assert_nil session[:handshake]
    assert_nil session[:user_id]
    assert_equal error.to_json, @response.body
  end

  test "logout should reset sessions user_id" do
    session[:user_id] = "set"
    delete :destroy
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to root_url
  end

end
