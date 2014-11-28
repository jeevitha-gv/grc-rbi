class ControlRegulation < ActiveRecord::Base

	has_many :control_regulations
	 scope :control_regulation_name, ->(id) { where(id: id).first.name}
	#scope :for_name, lambda { |control_regulation_name| where("lower(name)=?", control_regulation_name) }

end
