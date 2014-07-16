require 'test_helper'

class ClaimantsControllerTest < ActionController::TestCase
  setup do
    @claimant = claimants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claimants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claimant" do
    assert_difference('Claimant.count') do
      post :create, claimant: { first_name: @claimant.first_name, last_name: @claimant.last_name }
    end

    assert_redirected_to claimant_path(assigns(:claimant))
  end

  test "should show claimant" do
    get :show, id: @claimant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @claimant
    assert_response :success
  end

  test "should update claimant" do
    put :update, id: @claimant, claimant: { first_name: @claimant.first_name, last_name: @claimant.last_name }
    assert_redirected_to claimant_path(assigns(:claimant))
  end

  test "should destroy claimant" do
    assert_difference('Claimant.count', -1) do
      delete :destroy, id: @claimant
    end

    assert_redirected_to claimants_path
  end
end
