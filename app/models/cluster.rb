class Cluster < ActiveRecord::Base
  belongs_to :state
  belongs_to :release
  has_many :team_assignments, :dependent => :destroy
  has_many :notes, :as => :notable
  validates_presence_of :release_id
  validates_uniqueness_of :name, :scope => :release_id
  
  def current_team_assignments
	  team_assignments.find(:all, :conditions => ['state_id = ?',state.id]) 
  end
  after_update do |record|
  	record.team_assignments.find(:all, :conditions => ['state_id >= ?',record.state.id], :order => 'state_id ASC').each do |ta|
#  		ta.signed_off = false
  		ta.save
  	end
  end
  
  def body
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
