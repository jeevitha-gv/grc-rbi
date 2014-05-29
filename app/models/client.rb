
class Client < ActiveRecord::Base

  belongs_to :company #client belongs to a company
  validates :name, presence:true, :if => Proc.new{|f| f.name.blank? } 
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d]+\Z/i, :if => Proc.new{ |f| !f.name.blank? } 
  validates :name, uniqueness:true, :if => Proc.new{ |f| !f.name.blank? } 
  validates :name, length: { in: 4..52 }, :if => Proc.new{ |f| !f.name.blank? } 
  validates :address1, length: { in: 7..40 },:if => Proc.new{|f| !f.address1.blank? } 
  validates :address2, length: { in: 7..40 },:if => Proc.new{|f| !f.address2.blank? } 
  validates :email, presence: true,:if => Proc.new{|f| f.email.blank? } 
  validates :email, uniqueness: true,:if => Proc.new{|f| !f.email.blank? } 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create,:if => Proc.new{|f| !f.email.blank? } 
  validates :contact_no, presence:true, :if => Proc.new{|f| f.contact_no.blank? } 
  validates_numericality_of :contact_no, :if => Proc.new{|f| !f.contact_no.blank? } 
  validates :contact_no, length: { in: 10..12}, :if => Proc.new{|f| !f.contact_no.blank? } 
end
