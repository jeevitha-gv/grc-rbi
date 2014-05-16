class Team < ActiveRecord::Base

#associations
has_many :users, :through => :user_teams 
has_many :user_teams
end
