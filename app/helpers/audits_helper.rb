module AuditsHelper

	def standard_name(audit)
		if audit.compliance_type == 'Compliance'
			compliance = Compliance.where('id= ?', audit.standard_id).first
			compliance.name  unless compliance.nil?
		else
			topic = Topic.where('id= ?', audit.standard_id).first
			topic.name unless topic.nil?
		end
	end

end
