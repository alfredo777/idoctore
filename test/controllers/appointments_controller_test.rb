require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get move" do
    get :move
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
