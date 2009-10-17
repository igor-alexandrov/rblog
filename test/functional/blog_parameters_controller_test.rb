require 'test_helper'

class BlogParametersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_parameters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog_parameter" do
    assert_difference('BlogParameter.count') do
      post :create, :blog_parameter => { }
    end

    assert_redirected_to blog_parameter_path(assigns(:blog_parameter))
  end

  test "should show blog_parameter" do
    get :show, :id => blog_parameters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => blog_parameters(:one).to_param
    assert_response :success
  end

  test "should update blog_parameter" do
    put :update, :id => blog_parameters(:one).to_param, :blog_parameter => { }
    assert_redirected_to blog_parameter_path(assigns(:blog_parameter))
  end

  test "should destroy blog_parameter" do
    assert_difference('BlogParameter.count', -1) do
      delete :destroy, :id => blog_parameters(:one).to_param
    end

    assert_redirected_to blog_parameters_path
  end
end
