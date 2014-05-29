# The section Model is to track the Audit in the application.
class Section < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  #associations
  has_many :modulars #Section has many modulars
  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["section"]["name"]["name"]["failure"]}
  validates :name, presence:{message: MESSAGES["section"]["name"]["presence"]["failure"]}
  validates :name, uniqueness:{message: MESSAGES["section"]["name"]["uniqueness"]["failure"]}
end
