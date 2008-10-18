class Event < ActiveRecord::Base
	belongs_to :cluster
	belongs_to :team_assignment
	belongs_to :state	
end
