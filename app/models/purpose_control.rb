class PurposeControl < ActiveRecord::Base

	has_many :controls
	scope :control_purpose_name, ->(id) { where(id: id).first.name}

end
