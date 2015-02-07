require 'test_helper'

class DislikesControllerTest < ActionController::TestCase
  setup do
    @dislike = dislikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dislikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dislike" do
    assert_difference('Dislike.count') do
      post :create, dislike: { dislikeable_id: @dislike.dislikeable_id, dislikeable_type: @dislike.dislikeable_type, user_id: @dislike.user_id }
    end

    assert_redirected_to dislike_path(assigns(:dislike))
  end

  test "should show dislike" do
    get :show, id: @dislike
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dislike
    assert_response :success
  end

  test "should update dislike" do
    patch :update, id: @dislike, dislike: { dislikeable_id: @dislike.dislikeable_id, dislikeable_type: @dislike.dislikeable_type, user_id: @dislike.user_id }
    assert_redirected_to dislike_path(assigns(:dislike))
  end

  test "should destroy dislike" do
    assert_difference('Dislike.count', -1) do
      delete :destroy, id: @dislike
    end

    assert_redirected_to dislikes_path
  end
end
