# The Modular Model is to track the controller name and action in the application.
class Modular < ActiveRecord::Base
  validates :model_name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  validates :action_name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  #associations
  belongs_to :section
  has_many :previleges
end
