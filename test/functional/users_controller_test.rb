require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_equal User, assigns(:user).class
    assert_response :success
  end

  test "should create new user" do
    params = valid_user_params
    user = stub params
    params.stringify_keys!.except!('id')
    User.expects(:create!).with(params).returns(user)
    post :create, :user => params
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should redirect to signup form on failed attempt" do
    params = valid_user_params.slice(:login)
    user = User.new(params)
    params.stringify_keys!
    User.expects(:create!).with(params).raises(VALIDATION_FAILED.new(user))
    post :create, :user => params
    assert_nil session[:user_id]
    assert_equal user, assigns[:user]
    assert_response :success
    assert_template :new
  end

  def valid_user_params
    {
      :login => "me",
      :id => 123,
      :password_verifier => "1234",
      :password_salt => "4321"
    }
  end
end
