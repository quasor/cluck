require 'test_helper'

class ClustersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:clusters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cluster
    assert_difference('Cluster.count') do
      post :create, :cluster => { }
    end

    assert_redirected_to cluster_path(assigns(:cluster))
  end

  def test_should_show_cluster
    get :show, :id => clusters(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => clusters(:one).id
    assert_response :success
  end

  def test_should_update_cluster
    put :update, :id => clusters(:one).id, :cluster => { }
    assert_redirected_to cluster_path(assigns(:cluster))
  end

  def test_should_destroy_cluster
    assert_difference('Cluster.count', -1) do
      delete :destroy, :id => clusters(:one).id
    end

    assert_redirected_to clusters_path
  end
end
