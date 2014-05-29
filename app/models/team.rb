class Team < ActiveRecord::Base

#associations
has_many :users, :through => :user_teams 
has_many :user_teams

 validates :name, uniqueness:true
 validates :name, presence:true

end
