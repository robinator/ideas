require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    login!(:quentin)
  end

  test "should show category" do
    get :show, :id => categories(:quentin).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:quentin).to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => categories(:quentin).to_param, :category => { }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category if belongs to user" do
    assert_difference('Category.count', -1) do
      delete :destroy, :id => categories(:quentin).to_param
    end

    assert_redirected_to ideas_path
  end
  
  test "should not destroy another users category" do
    assert_no_difference('Category.count', -1) do
      delete :destroy, :id => categories(:two).to_param
    end
    
    assert_equal 'You do not have permission to access this category.', flash[:error]
    assert_redirected_to ideas_path
  end
end
