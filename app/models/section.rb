# The section Model is to track the Audit in the application.
class Section < ActiveRecord::Base
  
  #associations
  has_many :modulars #Section has many modulars

  validates :name, presence:true, :if => Proc.new{ |f| f.name.blank? } 
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? } 
  validates :name, uniqueness:true, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, length: { in: 4..52 }, :if => Proc.new{ |f| !f.name.blank? } 
end
