class Cluster < ActiveRecord::Base
  belongs_to :state
  belongs_to :release
  has_many :team_assignments, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  validates_presence_of :release_id
  validates_uniqueness_of :name, :scope => :release_id
  acts_as_taggable_on :groups
  acts_as_taggable_on :regions
	acts_as_taggable_on :type
  
  def current_team_assignments
	  team_assignments.find(:all, :conditions => ['state_id = ?',state.id]) 
  end

  def clear_signoffs
    next_states = State.find(:all, :conditions => ['sequence_number >= ?',state.sequence_number], :order => 'sequence_number ASC').collect(&:id)
  	team_assignments.find(:all, :conditions => {:state_id => next_states}).each do |ta|    
  	  ta.signed_off = false
  	  ta.save
  	end
  end
  
  def body
  end
  
  def reinit
		next_assignemnt = team_assignments.find(:first,:include => :state, :conditions => ['states.sequence_number > ?',0], :order => 'states.sequence_number ASC')
  	unless next_assignemnt.nil?
  		self.state_id = next_assignemnt.state.id
  		save!
  	end
  end
  def promote!
    #next_state = State.find(:first, :conditions => ['sequence_number > ?',state.sequence_number], :order => 'sequence_number ASC')
		next_assignment = team_assignments.find(:first,:include => :state, :conditions => ['states.sequence_number > ?',state.sequence_number], :order => 'states.sequence_number ASC')
		if next_assignment.nil? && !self.type_list.include?("TS")
			next_state = State.find(:first, :conditions => ['sequence_number > ?',state.sequence_number], :order => 'sequence_number ASC')
  		self.state_id = next_state.id
  		save!
		end
  	unless next_assignment.nil?
  		self.state_id = next_assignment.state.id
  		save!
  	end
  end
  
  def unshunted?
    self.state == State.find(:first, :order => 'sequence_number DESC')
  end
end
