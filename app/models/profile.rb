class Profile < ActiveRecord::Base

	belongs_to :user
	belongs_to :country
  validates_numericality_of :phone_no, presence: true
  validates :phone_no, length: { in: 7..30}
  validates :address1, length: { in: 7..40 }
  validates :address2, length: { in: 7..40 }
end
