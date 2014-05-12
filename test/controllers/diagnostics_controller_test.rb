require 'test_helper'

class DiagnosticsControllerTest < ActionController::TestCase
  setup do
    @diagnostic = diagnostics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diagnostics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diagnostic" do
    assert_difference('Diagnostic.count') do
      post :create, diagnostic: { diagnostic_or_clinical_problem: @diagnostic.diagnostic_or_clinical_problem, interrogation: @diagnostic.interrogation, list_of_laboratory_studies: @diagnostic.list_of_laboratory_studies, physical_examination: @diagnostic.physical_examination, required_therapies: @diagnostic.required_therapies, suggested_treatments: @diagnostic.suggested_treatments, user_id: @diagnostic.user_id }
    end

    assert_redirected_to diagnostic_path(assigns(:diagnostic))
  end

  test "should show diagnostic" do
    get :show, id: @diagnostic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diagnostic
    assert_response :success
  end

  test "should update diagnostic" do
    patch :update, id: @diagnostic, diagnostic: { diagnostic_or_clinical_problem: @diagnostic.diagnostic_or_clinical_problem, interrogation: @diagnostic.interrogation, list_of_laboratory_studies: @diagnostic.list_of_laboratory_studies, physical_examination: @diagnostic.physical_examination, required_therapies: @diagnostic.required_therapies, suggested_treatments: @diagnostic.suggested_treatments, user_id: @diagnostic.user_id }
    assert_redirected_to diagnostic_path(assigns(:diagnostic))
  end

  test "should destroy diagnostic" do
    assert_difference('Diagnostic.count', -1) do
      delete :destroy, id: @diagnostic
    end

    assert_redirected_to diagnostics_path
  end
end
