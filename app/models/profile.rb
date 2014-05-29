class Profile < ActiveRecord::Base

	belongs_to :user
	belongs_to :country
  validates_numericality_of :phone_no, presence: true
  validates :phone_no, length: { in: 7..12}
  validates :address1, length: { in: 7..40 }, :if => Proc.new{|f| !f.address1.blank? }
  validates :address2, length: { in: 7..40 }, :if => Proc.new{|f| !f.address2.blank? }
end
