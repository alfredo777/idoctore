require 'test_helper'

class OfficeAssistantsControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get doctors" do
    get :doctors
    assert_response :success
  end

  test "should get cites" do
    get :cites
    assert_response :success
  end

  test "should get messages" do
    get :messages
    assert_response :success
  end

end
