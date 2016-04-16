require 'test_helper'

class ContributionsControllerTest < ActionController::TestCase
  setup do
    @contribution = contributions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contributions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contribution" do
    assert_difference('Contribution.count') do
      post :create, contribution: { content: @contribution.content, contr_subtype: @contribution.contr_subtype, contr_type: @contribution.contr_type, parent_id: @contribution.parent_id, upvote: @contribution.upvote, url: @contribution.url, user_id: @contribution.user_id }
    end

    assert_redirected_to contribution_path(assigns(:contribution))
  end

  test "should show contribution" do
    get :show, id: @contribution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contribution
    assert_response :success
  end

  test "should update contribution" do
    patch :update, id: @contribution, contribution: { content: @contribution.content, contr_subtype: @contribution.contr_subtype, contr_type: @contribution.contr_type, parent_id: @contribution.parent_id, upvote: @contribution.upvote, url: @contribution.url, user_id: @contribution.user_id }
    assert_redirected_to contribution_path(assigns(:contribution))
  end

  test "should destroy contribution" do
    assert_difference('Contribution.count', -1) do
      delete :destroy, id: @contribution
    end

    assert_redirected_to contributions_path
  end
end
