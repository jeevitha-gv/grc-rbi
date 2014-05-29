class Priority < ActiveRecord::Base
  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["priority"]["name"]["name"]["failure"]}
  validates :name, presence:{message: MESSAGES["priority"]["name"]["presence"]["failure"]}
  validates :name, uniqueness:{message: MESSAGES["priority"]["name"]["uniqueness"]["failure"]}
end
