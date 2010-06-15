require 'test_helper'

class StylesControllerTest < ActionController::TestCase
  setup do
    @style = styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create style" do
    assert_difference('Style.count') do
      post :create, :style => @style.attributes
    end

    assert_redirected_to style_path(assigns(:style))
  end

  test "should show style" do
    get :show, :id => @style.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @style.to_param
    assert_response :success
  end

  test "should update style" do
    put :update, :id => @style.to_param, :style => @style.attributes
    assert_redirected_to style_path(assigns(:style))
  end

  test "should destroy style" do
    assert_difference('Style.count', -1) do
      delete :destroy, :id => @style.to_param
    end

    assert_redirected_to styles_path
  end
end
