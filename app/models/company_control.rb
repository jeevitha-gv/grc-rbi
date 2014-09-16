class CompanyControl < ActiveRecord::Base

	# Associations
	has_many :policies

	belongs_to :control_classification
	belongs_to :purpose
	belongs_to :control_state
	belongs_to :control_freq
	belongs_to :standard, class_name: "Compliance", foreign_key: :standard_id
	belongs_to :company
end
