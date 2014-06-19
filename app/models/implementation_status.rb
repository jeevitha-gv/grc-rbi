class ImplementationStatus < ActiveRecord::Base

  # Associations
  has_many :cpp_measures
end
