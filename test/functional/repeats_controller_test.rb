require 'test_helper'

class RepeatsControllerTest < ActionController::TestCase
  setup do
    @repeat = repeats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repeats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repeat" do
    assert_difference('Repeat.count') do
      post :create, :repeat => @repeat.attributes
    end

    assert_redirected_to repeat_path(assigns(:repeat))
  end

  test "should show repeat" do
    get :show, :id => @repeat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @repeat.to_param
    assert_response :success
  end

  test "should update repeat" do
    put :update, :id => @repeat.to_param, :repeat => @repeat.attributes
    assert_redirected_to repeat_path(assigns(:repeat))
  end

  test "should destroy repeat" do
    assert_difference('Repeat.count', -1) do
      delete :destroy, :id => @repeat.to_param
    end

    assert_redirected_to repeats_path
  end
end
