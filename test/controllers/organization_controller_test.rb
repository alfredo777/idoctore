require 'test_helper'

class OrganizationControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get patients" do
    get :patients
    assert_response :success
  end

  test "should get patients_new" do
    get :patients_new
    assert_response :success
  end

  test "should get doctors" do
    get :doctors
    assert_response :success
  end

  test "should get doctors_new" do
    get :doctors_new
    assert_response :success
  end

  test "should get assistants" do
    get :assistants
    assert_response :success
  end

  test "should get assistants_new" do
    get :assistants_new
    assert_response :success
  end

  test "should get hospitals" do
    get :hospitals
    assert_response :success
  end

  test "should get hospitals_new" do
    get :hospitals_new
    assert_response :success
  end

  test "should get admins" do
    get :admins
    assert_response :success
  end

  test "should get admin_new" do
    get :admin_new
    assert_response :success
  end

  test "should get dependencies" do
    get :dependencies
    assert_response :success
  end

  test "should get dependency_new" do
    get :dependency_new
    assert_response :success
  end

  test "should get payments_controll_by_dependency" do
    get :payments_controll_by_dependency
    assert_response :success
  end

  test "should get rates" do
    get :rates
    assert_response :success
  end

  test "should get rates_new" do
    get :rates_new
    assert_response :success
  end

  test "should get rates_update" do
    get :rates_update
    assert_response :success
  end

end
