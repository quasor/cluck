class Cluster < ActiveRecord::Base
  belongs_to :state
  belongs_to :release
  has_many :team_assignments, :dependent => :destroy
  def current_team_assignments
	team_assignments.find(:all, :conditions => ['state_id = ?',state.id]) 
  end
  def reinit
   next_state = State.find(:first, :conditions => ['sequence_number > ?',0], :order => 'sequence_number ASC')
	unless next_state.nil?
		self.state_id = next_state.id
		save!
	end
  end
  def promote!
    next_state = State.find(:first, :conditions => ['sequence_number > ?',state.sequence_number], :order => 'sequence_number ASC')
	unless next_state.nil?
		self.state_id = next_state.id
		save!
	end
  end
end
