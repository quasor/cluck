class AddReleaseToTeamAssignment < ActiveRecord::Migration
  def self.up
    add_column :team_assignments, :release_id, :integer
  end

  def self.down
    remove_column :team_assignments, :release_id
  end
end
