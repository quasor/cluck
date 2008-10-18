class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :action
      t.integer :release_id
      t.integer :team_assignment_id
      t.integer :cluster_id
      t.boolean :signed_off
      t.integer :state_id
      t.string :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
