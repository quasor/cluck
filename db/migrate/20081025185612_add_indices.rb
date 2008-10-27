class AddIndices < ActiveRecord::Migration
  def self.up
    add_index(:team_assignments, [:cluster_id, :team_id, :state_id])
    add_index(:team_assignments, [:cluster_id, :state_id])
    add_index(:clusters, :state_id)
    add_index(:clusters, [:release_id, :state_id])
  	TeamAssignment.reset_column_information
  	TeamAssignment.create_versioned_table
    
  end

  def self.down
    remove_index(:team_assignments, [:cluster_id, :team_id, :state_id])
    remove_index(:team_assignments, [:cluster_id, :state_id])
    remove_index(:clusters, :state_id)
    remove_index(:clusters, [:release_id, :state_id])
  end
end
