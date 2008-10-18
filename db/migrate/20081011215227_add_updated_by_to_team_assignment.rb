class AddUpdatedByToTeamAssignment < ActiveRecord::Migration
  def self.up
    add_column :team_assignments, :updated_by, :string
  end

  def self.down
    remove_column :team_assignments, :updated_by
  end
end
