class ImplementationStatus < ActiveRecord::Base

  # Associations
  has_many :cpp_measures, dependent: :destroy
  has_many :bc_implementations
end
