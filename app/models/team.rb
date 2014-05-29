class Team < ActiveRecord::Base

#associations
has_many :users, :through => :user_teams 
has_many :user_teams

 validates :name, uniqueness:{ message: MESSAGES["team"]["name"]["uniqueness"]["failure"]}
 validates :name, presence:{ message: MESSAGES["team"]["name"]["presence"]["failure"]}

end
