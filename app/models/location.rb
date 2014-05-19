class Location < ActiveRecord::Base
  validates :name, uniqueness: {scope: :company_id}, presence: true, format: { with: /\A[a-zA-Z]+\z/ }

  has_many :departments
  belongs_to :company

end
