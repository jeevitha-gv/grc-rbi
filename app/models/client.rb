
class Client < ActiveRecord::Base

  belongs_to :company #client belongs to a company
  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["client"]["name"]["name"]["failure"]}
  validates :name, presence:{message: MESSAGES["client"]["name"]["presence"]["failure"]}
  validates :name, uniqueness:{message: MESSAGES["client"]["name"]["uniqueness"]["failure"]}
  validates :name, length: { maximum: 52 }, presence:{message: MESSAGES["client"]["name"]["length"]["failure"]}
  validates :address1, length: { in: 7..40 }, presence:{message: MESSAGES["client"]["address1"]["length"]["failure"]}
  validates :address2, length: { in: 7..40 }, presence:{message: MESSAGES["client"]["address2"]["length"]["failure"]}
  validates :email, presence: { message: MESSAGES["client"]["email"]["presence"]["failure"] }
  validates :email, uniqueness:{ message: MESSAGES["client"]["email"]["uniqueness"]["failure"]}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, presence:{message: MESSAGES["client"]["email"]["valid"]["failure"]}
  validates_numericality_of :contact_no, presence:{message: MESSAGES["client"]["contact"]["number"]["failure"]}
  validates :contact_no, length: { is: 10}, presence:{message: MESSAGES["client"]["contact"]["length"]["failure"]}
end
