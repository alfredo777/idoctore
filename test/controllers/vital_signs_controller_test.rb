require 'test_helper'

class VitalSignsControllerTest < ActionController::TestCase
  setup do
    @vital_sign = vital_signs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vital_signs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vital_sign" do
    assert_difference('VitalSign.count') do
      post :create, vital_sign: { blood_pressure_down: @vital_sign.blood_pressure_down, blood_pressure_up: @vital_sign.blood_pressure_up, breathing: @vital_sign.breathing, height: @vital_sign.height, pulse: @vital_sign.pulse, temperature: @vital_sign.temperature, weight: @vital_sign.weight }
    end

    assert_redirected_to vital_sign_path(assigns(:vital_sign))
  end

  test "should show vital_sign" do
    get :show, id: @vital_sign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vital_sign
    assert_response :success
  end

  test "should update vital_sign" do
    patch :update, id: @vital_sign, vital_sign: { blood_pressure_down: @vital_sign.blood_pressure_down, blood_pressure_up: @vital_sign.blood_pressure_up, breathing: @vital_sign.breathing, height: @vital_sign.height, pulse: @vital_sign.pulse, temperature: @vital_sign.temperature, weight: @vital_sign.weight }
    assert_redirected_to vital_sign_path(assigns(:vital_sign))
  end

  test "should destroy vital_sign" do
    assert_difference('VitalSign.count', -1) do
      delete :destroy, id: @vital_sign
    end

    assert_redirected_to vital_signs_path
  end
end
