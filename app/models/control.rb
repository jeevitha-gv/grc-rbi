class Control < ActiveRecord::Base


	belongs_to :classification_control
	belongs_to :purpose_control
	belongs_to :control_owner, class_name: 'User', foreign_key: 'owner'
	belongs_to :control_delegate, class_name: 'User', foreign_key: 'owner_delegate'
	belongs_to :owning_group
	belongs_to :control_regulation
	belongs_to :fraud_related
	belongs_to :control_status_id
	belongs_to :data_purpose_id
	has_one :control_approval
	has_one :control_review
	has_one :control_audit
    #has_one :attachment, as: :attachable
    belongs_to :control_owner, class_name: 'User', foreign_key: 'owner'
    belongs_to :control_owner_delegate, class_name: 'User', foreign_key: 'owner_delegate'

	accepts_nested_attributes_for :control_approval
	accepts_nested_attributes_for :control_review
	accepts_nested_attributes_for :control_audit

    #accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }
    delegate :name, :to => :control_approval, prefix: true, allow_nil: true
	delegate :name, :to => :control_review, prefix: true, allow_nil: true
	delegate :name, :to => :control_audit, prefix: true, allow_nil: true

	delegate :user_name, to: :control_owner, prefix: true, allow_nil: true
	delegate :user_name, to: :control_delegate, prefix: true, allow_nil: true
	
end
