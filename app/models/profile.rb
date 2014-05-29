class Profile < ActiveRecord::Base

	belongs_to :user
	belongs_to :country
  validates_numericality_of :phone_no, presence:{message: MESSAGES["profile"]["contact"]["number"]["failure"]}
  validates :phone_no, length: { in: 7..30}, presence:{message: MESSAGES["profile"]["contact"]["length"]["failure"]}
  validates :address1, length: { in: 7..40 }, presence:{message: MESSAGES["profile"]["address1"]["length"]["failure"]}
  validates :address2, length: { in: 7..40 }, presence:{message: MESSAGES["profile"]["address2"]["length"]["failure"]}
end
