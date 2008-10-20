class CreateTeamAssignments < ActiveRecord::Migration
  def self.up
    create_table :team_assignments do |t|
      t.integer :cluster_id
      t.integer :team_id
      t.integer :state_id
      t.boolean :signed_off, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :team_assignments
  end
end
