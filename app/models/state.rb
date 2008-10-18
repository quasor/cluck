class State < ActiveRecord::Base
	has_many :default_team_assignments
	has_many :team_assignments
end
