require 'test_helper'

class CustomInputsControllerTest < ActionController::TestCase
  setup do
    @custom_input = custom_inputs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_inputs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_input" do
    assert_difference('CustomInput.count') do
      post :create, custom_input: { amount: @custom_input.amount, description: @custom_input.description, type: @custom_input.type }
    end

    assert_redirected_to custom_input_path(assigns(:custom_input))
  end

  test "should show custom_input" do
    get :show, id: @custom_input
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_input
    assert_response :success
  end

  test "should update custom_input" do
    patch :update, id: @custom_input, custom_input: { amount: @custom_input.amount, description: @custom_input.description, type: @custom_input.type }
    assert_redirected_to custom_input_path(assigns(:custom_input))
  end

  test "should destroy custom_input" do
    assert_difference('CustomInput.count', -1) do
      delete :destroy, id: @custom_input
    end

    assert_redirected_to custom_inputs_path
  end
end
