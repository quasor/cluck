class Release < ActiveRecord::Base
  has_many :clusters, :dependent => :destroy
  has_many :teams, :through => :team_assignments
  validates_uniqueness_of :name
  def update_default_assignments
	for dta in DefaultTeamAssignment.all
		for cluster in clusters
			if TeamAssignment.find(:first,:conditions => {:cluster_id => cluster.id, :team_id => dta.team_id, :state_id => dta.state_id}).nil?
				TeamAssignment.create(:cluster_id => cluster.id, :team_id => dta.team_id, :state_id => dta.state_id, :signed_off => :false)
			end
		end
	end
  end
  
  def clone_from(src)
	for cluster in src.clusters
		c = Cluster.new(:name => cluster.name)
		self.clusters << c
		for team_assignment in cluster.team_assignments
			TeamAssignment.create(:cluster_id => c.id, :team_id => team_assignment.team_id, :state_id => team_assignment.state_id, :signed_off => false)
		end
		c.reinit
	end
  end
  
end

