class Collapseteams < ActiveRecord::Migration
  def self.up
		team_sources = [4, 6, 13]
		team_target = Team.find_or_create_by_name("EWE").id
		release = Release.find 11
		for team_source in team_sources
			for cluster in release.clusters do
				puts "processing #{cluster.name}"
				for team_assignment in cluster.team_assignments.find(:all, :conditions => {:team_id => team_source})
					puts 'team_assignment' + team_assignment.inspect
					t = TeamAssignment.find_by_cluster_id_and_team_id(cluster.id, team_target.id)
					if t.nil?
						t = team_assignment.clone
						t.team_id = team_target
						t.save
					end
					team_assignment.delete
				end
			end
		end
  end

  def self.down
  end
end
