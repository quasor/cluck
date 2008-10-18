require 'test_helper'

class DefaultTeamAssignmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:default_team_assignments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_default_team_assignment
    assert_difference('DefaultTeamAssignment.count') do
      post :create, :default_team_assignment => { }
    end

    assert_redirected_to default_team_assignment_path(assigns(:default_team_assignment))
  end

  def test_should_show_default_team_assignment
    get :show, :id => default_team_assignments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => default_team_assignments(:one).id
    assert_response :success
  end

  def test_should_update_default_team_assignment
    put :update, :id => default_team_assignments(:one).id, :default_team_assignment => { }
    assert_redirected_to default_team_assignment_path(assigns(:default_team_assignment))
  end

  def test_should_destroy_default_team_assignment
    assert_difference('DefaultTeamAssignment.count', -1) do
      delete :destroy, :id => default_team_assignments(:one).id
    end

    assert_redirected_to default_team_assignments_path
  end
end
