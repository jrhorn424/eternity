require 'test_helper'

class ClaimSubmissionsControllerTest < ActionController::TestCase
  setup do
    @claim_submission = claim_submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claim_submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claim_submission" do
    assert_difference('ClaimSubmission.count') do
      post :create, claim_submission: {  }
    end

    assert_redirected_to claim_submission_path(assigns(:claim_submission))
  end

  test "should show claim_submission" do
    get :show, id: @claim_submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @claim_submission
    assert_response :success
  end

  test "should update claim_submission" do
    put :update, id: @claim_submission, claim_submission: {  }
    assert_redirected_to claim_submission_path(assigns(:claim_submission))
  end

  test "should destroy claim_submission" do
    assert_difference('ClaimSubmission.count', -1) do
      delete :destroy, id: @claim_submission
    end

    assert_redirected_to claim_submissions_path
  end
end
