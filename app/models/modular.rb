# The Modular Model is to track the controller name and action in the application.
class Modular < ActiveRecord::Base
  validates :section_id, presence:true
  validates_format_of :model_name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :model_name, presence:true
  validates :model_name, uniqueness:true
  validates_format_of :action_name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :action_name, presence:true
  validates :action_name, uniqueness:true
  #associations
  belongs_to :section
  has_many :privileges
end
