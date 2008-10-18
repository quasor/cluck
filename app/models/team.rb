class Team < ActiveRecord::Base
  has_many :team_assignments
  has_many :clusters, :through => :team_assignments
end
