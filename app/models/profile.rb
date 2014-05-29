class Profile < ActiveRecord::Base

	belongs_to :user
	belongs_to :country
  validates_numericality_of :phone_no, presence: true, :if => Proc.new{|f| !f.phone_no.blank? }
  validates :phone_no, length: { is: 10 }, :if => Proc.new{|f| !f.phone_no.blank? }
  validates :address1, length: { in: 7..40 }, :if => Proc.new{|f| !f.address1.blank? }
  validates :address2, length: { in: 7..40 }, :if => Proc.new{|f| !f.address2.blank? }
end
