json.data do |json|

	json.array!(@policies) do |policy|
	  json.id policy.id
		json.title policy.title
		json.classification policy.policy_classification_name
		json.distribution policy.audience_name
		json.kind policy.policy_kind_name
		json.version policy.versions.size
		json.owner policy.policy_owner_user_name
	end
end