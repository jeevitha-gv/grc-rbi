class FraudRelated < ActiveRecord::Base

	has_many :control_reviews
	has_many :controls
	scope :fraud_related_name, ->(id) { where(id: id).first.name}

end
