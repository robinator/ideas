require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ideas" do
    assert_difference('Idea.count') do
      post :create, :ideas => { }
    end

    assert_redirected_to ideas_path(assigns(:ideas))
  end

  test "should show ideas" do
    get :show, :id => ideas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ideas(:one).to_param
    assert_response :success
  end

  test "should update ideas" do
    put :update, :id => ideas(:one).to_param, :ideas => { }
    assert_redirected_to ideas_path(assigns(:ideas))
  end

  test "should destroy ideas" do
    assert_difference('Idea.count', -1) do
      delete :destroy, :id => ideas(:one).to_param
    end

    assert_redirected_to ideas_path
  end
end
