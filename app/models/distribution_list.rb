class DistributionList < ActiveRecord::Base

	# Associations
	has_many :publish_distribution_list
	belongs_to :company

	def email_list=(arg)
  		self.email_ids = arg.split(',').map {|v| v.strip}
  	end

  	def email_list
  		self.email_ids.join(', ')
  	end

end
