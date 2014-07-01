class Plan < ActiveRecord::Base
	belongs_to :company
	belongs_to :subscription
end