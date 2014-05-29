
class Client < ActiveRecord::Base

  belongs_to :company #client belongs to a company
  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :name, presence:true
  validates :name, uniqueness:true
  validates :name, length: { maximum: 52 }
  validates :address1, length: { in: 7..40 }
  validates :address2, length: { in: 7..40 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_numericality_of :contact_no
  validates :contact_no, length: { is: 10}
end
