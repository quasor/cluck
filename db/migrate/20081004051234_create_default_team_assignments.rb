class CreateDefaultTeamAssignments < ActiveRecord::Migration
  def self.up
    create_table :default_team_assignments do |t|
      t.integer :team_id
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :default_team_assignments
  end
end
