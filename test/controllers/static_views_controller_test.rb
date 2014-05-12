require 'test_helper'

class StaticViewsControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get prices" do
    get :prices
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get about_us" do
    get :about_us
    assert_response :success
  end

end
