require 'test_helper'

class HospitalsControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get loggin" do
    get :loggin
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get stats" do
    get :stats
    assert_response :success
  end

end
