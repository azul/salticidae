require 'test_helper'

class CertsControllerTest < ActionController::TestCase
  setup do
  end

  test "should show cert" do
    get :show
    assert_response :success
  end
end
