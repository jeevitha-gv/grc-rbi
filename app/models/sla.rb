class Sla < ActiveRecord::Base

	has_many :evaluates

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
	validates :description, length: { maximum: 250 }, :if => Proc.new{|f| !f.description.blank? }
	validates_numericality_of :days, :if => Proc.new{|f| !f.days.blank? }
	validates_numericality_of :hours, :if => Proc.new{|f| !f.hours.blank? }
	validates_numericality_of :minutes, :if => Proc.new{|f| !f.minutes.blank? }
	validates :holidays, presence:true, length: { in: 0..50 }

end
