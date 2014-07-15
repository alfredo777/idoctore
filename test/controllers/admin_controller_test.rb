require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get cupons" do
    get :cupons
    assert_response :success
  end

  test "should get payments" do
    get :payments
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end

end
