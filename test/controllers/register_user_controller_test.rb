require 'test_helper'

class RegisterUserControllerTest < ActionController::TestCase
  test "should get select_plan" do
    get :select_plan
    assert_response :success
  end

  test "should get insert_user_data" do
    get :insert_user_data
    assert_response :success
  end

  test "should get insert_payment_data" do
    get :insert_payment_data
    assert_response :success
  end

end
