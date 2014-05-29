# The Modular Model is to track the controller name and action in the application.
class Modular < ActiveRecord::Base
  validates :section_id, presence:{message: MESSAGES["modular"]["section"]["name"]["failure"]}
  validates_format_of :model_name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["modular"]["model"]["name"]["failure"]}
  validates :model_name, presence:{message: MESSAGES["modular"]["model"]["presence"]["failure"]}
  validates :model_name, uniqueness:{message: MESSAGES["modular"]["model"]["uniqueness"]["failure"]}
  validates_format_of :action_name, :with =>/\A[a-zA-Z1-9]+\z/, presence:{message: MESSAGES["modular"]["action"]["name"]["failure"]}
  validates :action_name, presence:{message: MESSAGES["modular"]["action"]["presence"]["failure"]}
  validates :action_name, uniqueness:{message: MESSAGES["modular"]["action"]["uniqueness"]["failure"]}
  #associations
  belongs_to :section
  has_many :privileges
end
