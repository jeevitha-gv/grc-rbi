class ClassificationControl < ActiveRecord::Base

	has_many :controls
	scope :classification_control_name, ->(id) { where(id: id).first.name}


end
