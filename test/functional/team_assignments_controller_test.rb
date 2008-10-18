require 'test_helper'

class TeamAssignmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:team_assignments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_team_assignment
    assert_difference('TeamAssignment.count') do
      post :create, :team_assignment => { }
    end

    assert_redirected_to team_assignment_path(assigns(:team_assignment))
  end

  def test_should_show_team_assignment
    get :show, :id => team_assignments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => team_assignments(:one).id
    assert_response :success
  end

  def test_should_update_team_assignment
    put :update, :id => team_assignments(:one).id, :team_assignment => { }
    assert_redirected_to team_assignment_path(assigns(:team_assignment))
  end

  def test_should_destroy_team_assignment
    assert_difference('TeamAssignment.count', -1) do
      delete :destroy, :id => team_assignments(:one).id
    end

    assert_redirected_to team_assignments_path
  end
end
