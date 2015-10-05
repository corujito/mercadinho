require 'test_helper'

class InOutCardsControllerTest < ActionController::TestCase
  setup do
    @in_out_card = in_out_cards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:in_out_cards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create in_out_card" do
    assert_difference('InOutCard.count') do
      post :create, in_out_card: { card_id: @in_out_card.card_id, inout_type: @in_out_card.inout_type }
    end

    assert_redirected_to in_out_card_path(assigns(:in_out_card))
  end

  test "should show in_out_card" do
    get :show, id: @in_out_card
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @in_out_card
    assert_response :success
  end

  test "should update in_out_card" do
    patch :update, id: @in_out_card, in_out_card: { card_id: @in_out_card.card_id, inout_type: @in_out_card.inout_type }
    assert_redirected_to in_out_card_path(assigns(:in_out_card))
  end

  test "should destroy in_out_card" do
    assert_difference('InOutCard.count', -1) do
      delete :destroy, id: @in_out_card
    end

    assert_redirected_to in_out_cards_path
  end
end
