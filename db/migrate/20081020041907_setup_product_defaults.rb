class SetupProductDefaults < ActiveRecord::Migration
  def self.up
    State.find_or_create_by_name(:name => 'Pre-release', :sequence_number => 1)
    State.find_or_create_by_name(:name => 'Shunted', :sequence_number => 2)
    State.find_or_create_by_name(:name => 'RTA', :sequence_number => 3)
    State.find_or_create_by_name(:name => 'RTT', :sequence_number => 4)
    State.find_or_create_by_name(:name => 'Ready to Unshunt', :sequence_number => 5)
    State.find_or_create_by_name(:name => 'Wahoo', :sequence_number => 6)
    @team = Team.find_or_create_by_name("Release Management")
    DefaultTeamAssignment.create(:state_id => 1, :team_id => @team.id)
    DefaultTeamAssignment.create(:state_id => 5, :team_id => @team.id)
    @team = Team.find_or_create_by_name("Ops")
    DefaultTeamAssignment.create(:state_id => 2, :team_id => @team.id)
    @team = Team.find_or_create_by_name("Automation Crew")
    DefaultTeamAssignment.create(:state_id => 3, :team_id => @team.id)
  end

  def self.down
  end
end
