# The section Model is to track the Audit in the application.
class Section < ActiveRecord::Base

  #associations
  has_many :modulars #Section has many modulars
end
