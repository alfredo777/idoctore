require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search_help" do
    get :search_help
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
