class DefaultTeamAssignment < ActiveRecord::Base
  belongs_to :state
  belongs_to :team
end

