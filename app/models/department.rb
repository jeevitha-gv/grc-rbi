class Department < ActiveRecord::Base
  belongs_to :location

  validates :name, presence:true, :if => Proc.new{|f| f.name.blank? } 
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i,:if => Proc.new{|f| !f.name.blank? } 
  validates :location_id, presence:true
end
