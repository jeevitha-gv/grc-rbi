json.array!(@policies) do |policy|
    json.id policy.id
    json.title policy.title
    json.start policy.effective_from
    json.start_date policy.effective_from
    json.end policy.effective_from
    json.end_date policy.effective_till
end