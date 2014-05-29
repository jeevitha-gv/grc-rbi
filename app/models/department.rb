class Department < ActiveRecord::Base
  belongs_to :location

  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["department"]["name"]["name"]["failure"]}
  validates :name, presence:{message: MESSAGES["department"]["name"]["presence"]["failure"]}
end
