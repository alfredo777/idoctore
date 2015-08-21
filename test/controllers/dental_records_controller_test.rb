require 'test_helper'

class DentalRecordsControllerTest < ActionController::TestCase
  setup do
    @dental_record = dental_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dental_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dental_record" do
    assert_difference('DentalRecord.count') do
      post :create, dental_record: { clinical_history_id: @dental_record.clinical_history_id, note: @dental_record.note, user_id: @dental_record.user_id }
    end

    assert_redirected_to dental_record_path(assigns(:dental_record))
  end

  test "should show dental_record" do
    get :show, id: @dental_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dental_record
    assert_response :success
  end

  test "should update dental_record" do
    patch :update, id: @dental_record, dental_record: { clinical_history_id: @dental_record.clinical_history_id, note: @dental_record.note, user_id: @dental_record.user_id }
    assert_redirected_to dental_record_path(assigns(:dental_record))
  end

  test "should destroy dental_record" do
    assert_difference('DentalRecord.count', -1) do
      delete :destroy, id: @dental_record
    end

    assert_redirected_to dental_records_path
  end
end
