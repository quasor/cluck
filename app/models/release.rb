class Release < ActiveRecord::Base
  has_many :clusters, :dependent => :destroy
  has_many :teams, :through => :team_assignments
  validates_uniqueness_of :name
  def update_default_assignments
		for cluster in clusters
			if cluster.team_assignments.empty?
				for dta in DefaultTeamAssignment.all
					if TeamAssignment.find(:first,:conditions => {:cluster_id => cluster.id, :team_id => dta.team_id, :state_id => dta.state_id}).nil?
						TeamAssignment.create(:cluster_id => cluster.id, :team_id => dta.team_id, :state_id => dta.state_id, :signed_off => :false)
					end
				end
			end
		end
  end

	def auto_promote_empty
		for cluster in clusters
		end
	end
  
  def clone_from(src)
	for cluster in src.clusters
		# TODO make shallow copy
		c = Cluster.new(:name => cluster.name)
		c.group_list = cluster.group_list
		c.region_list = cluster.region_list
		c.type_list = cluster.type_list
		self.clusters << c
		for team_assignment in cluster.team_assignments
			TeamAssignment.create(:cluster_id => c.id, :team_id => team_assignment.team_id, :state_id => team_assignment.state_id, :signed_off => false)
		end
		c.reinit
	end
  end
  
end

