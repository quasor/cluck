class TeamAssignment < ActiveRecord::Base
  acts_as_versioned
  belongs_to :cluster
  belongs_to :team
  belongs_to :state
  named_scope :assignment_is, lambda {|s| { :conditions => {:state_id => s.id} } }

  after_update do |record|
	record.reload
	promotion = false
	action = ""
	if !record.cluster.current_team_assignments.collect {|ta| ta.signed_off }.include?(false)
		record.cluster.promote!
		promotion = true
		record.cluster.reload
		action = record.cluster.state.name
	end
	Event.create(
		:release_id => record.cluster.release.id,
		:state_id => record.state_id,
		:action => action,
		:cluster_id => record.cluster.id, 
		:team_assignment_id => record.id, 
		:signed_off => record.signed_off,
		:updated_by => record.updated_by)
  end
end
