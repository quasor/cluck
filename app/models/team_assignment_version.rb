class TeamAssignmentVersion < ActiveRecord::Base
  belongs_to :cluster
  belongs_to :team
  belongs_to :state
  belongs_to :team_assignment
  named_scope :assignment_is, lambda {|s| { :conditions => {:state_id => s.id} } }
end