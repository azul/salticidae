require 'test_helper'

class CertsControllerTest < ActionController::TestCase
  setup do
    @cert = certs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:certs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cert" do
    assert_difference('Cert.count') do
      post :create, :cert => {  }
    end

    assert_redirected_to cert_path(assigns(:cert))
  end

  test "should show cert" do
    get :show, :id => @cert
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cert
    assert_response :success
  end

  test "should update cert" do
    put :update, :id => @cert, :cert => {  }
    assert_redirected_to cert_path(assigns(:cert))
  end

  test "should destroy cert" do
    assert_difference('Cert.count', -1) do
      delete :destroy, :id => @cert
    end

    assert_redirected_to certs_path
  end
end
