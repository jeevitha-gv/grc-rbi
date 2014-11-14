module PoliciesHelper
	def get_policy_status(policy_status_id, status)
	id = PolicyStatus.where('name= ?', status).first.try(&:id)
		if policy_status_id == id 
			'btn btn-success btn-circle'
		elsif policy_status_id >= id
			'btn btn-info btn-circle'
		else
			'btn btn-default btn-circle'
		end
	end
end