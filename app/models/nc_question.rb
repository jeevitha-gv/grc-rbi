class NcQuestion < ActiveRecord::Base
	belongs_to :question_type
	belongs_to :priority
	belongs_to :company
	belongs_to :user
end
