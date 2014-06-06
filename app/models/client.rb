
class Client < ActiveRecord::Base
  # associations
  has_many :audits
  belongs_to :company #client belongs to a company


  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, uniqueness:true, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, length: { in: 4..52 }, :if => Proc.new{ |f| !f.name.blank? }
  validates :address1, length: { in: 7..40 },:if => Proc.new{|f| !f.address1.blank? }
  validates :address2, length: { in: 7..40 },:if => Proc.new{|f| !f.address2.blank? }
  validates :email, presence: true
  validates :email, uniqueness: true,:if => Proc.new{|f| !f.email.blank? }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create,:if => Proc.new{|f| !f.email.blank? }
  validates :contact_no, presence:true
  validates_numericality_of :contact_no, :if => Proc.new{|f| !f.contact_no.blank? }
  validates :contact_no, length: { is: 10 }, :if => Proc.new{|f| !f.contact_no.blank? }
end
