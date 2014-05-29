class Team < ActiveRecord::Base

#associations
has_many :users, :through => :user_teams 
has_many :user_teams
belongs_to :company
 validates :name, presence:true, :if => Proc.new{|f| f.name.blank? }
 validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? } 
 validates :name, uniqueness:true, :if => Proc.new{ |f| !f.name.blank? } 

end
