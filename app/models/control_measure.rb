class ControlMeasure < ActiveRecord::Base

	# Associations
	belongs_to :risk
	belongs_to :risk_scoring
	
	before_save :check_empty_params
	before_update :check_empty_params
	
	def check_empty_params
		self.control_ids = self.control_ids.reject{|x| !x.present?}
		self.process_ids = self.process_ids.reject{|x| !x.present?}
		self.procedure_ids = self.procedure_ids.reject{|x| !x.present?}
	end
end
