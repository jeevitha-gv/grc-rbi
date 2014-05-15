# The Modular Model is to track the controller name and action in the application.
class Modular < ActiveRecord::Base

  #associations
  belongs_to :sections
end
