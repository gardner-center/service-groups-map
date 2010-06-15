require 'test_helper'

class ServicePeopleControllerTest < ActionController::TestCase
  setup do
    @service_person = service_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_person" do
    assert_difference('ServicePerson.count') do
      post :create, :service_person => @service_person.attributes
    end

    assert_redirected_to service_person_path(assigns(:service_person))
  end

  test "should show service_person" do
    get :show, :id => @service_person.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @service_person.to_param
    assert_response :success
  end

  test "should update service_person" do
    put :update, :id => @service_person.to_param, :service_person => @service_person.attributes
    assert_redirected_to service_person_path(assigns(:service_person))
  end

  test "should destroy service_person" do
    assert_difference('ServicePerson.count', -1) do
      delete :destroy, :id => @service_person.to_param
    end

    assert_redirected_to service_people_path
  end
end
