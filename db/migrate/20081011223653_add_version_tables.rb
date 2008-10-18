class AddVersionTables < ActiveRecord::Migration
  def self.up
	TeamAssignment.reset_column_information
	TeamAssignment.create_versioned_table
  end

  def self.down
	TeamAssignment.drop_versioned_table
  end
end
