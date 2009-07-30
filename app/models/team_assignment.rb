class TeamAssignment < ActiveRecord::Base
  acts_as_versioned
  
  attr_accessor :auto_promote
  
  belongs_to :cluster
  belongs_to :team
  belongs_to :state
  
	validates_uniqueness_of :team_id, :scope => [:cluster_id, :state_id]
  
  named_scope :assignment_is, lambda {|s| { :conditions => {:state_id => s.id} } }

  after_update do |record|
  	record.reload
  	promotion = false
  	action = ""
  
    # handle promotions
    if record.auto_promote
    	if !record.cluster.current_team_assignments.collect {|ta| ta.signed_off }.include?(false)
    		record.cluster.promote!
    		promotion = true
    		record.cluster.reload
    		action = record.cluster.state.name
    	end
	  end
		
	  # log sign-off events for reporting
  	Event.create(
  		:release_id => record.cluster.release.id,
  		:state_id => record.state_id,
  		:action => action,
  		:cluster_id => record.cluster.id, 
  		:team_assignment_id => record.id, 
  		:signed_off => record.signed_off,
  		:updated_by => record.updated_by) if record.signed_off == true #&& promotion == false
    end
end
