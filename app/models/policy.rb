class Policy < ActiveRecord::Base


	# Papertrail
	has_paper_trail
	
	# Associations
	belongs_to :company
	belongs_to :policy_kind
	belongs_to :audience
	belongs_to :policy_classification
	belongs_to :department
	belongs_to :standard, class_name: "Compliance", foreign_key: :standard_id
	belongs_to :company_control
	belongs_to :policy_owner, class_name: "User", foreign_key: :owner
	belongs_to :policy_status

	has_many :policy_handlers
	has_many :policy_locations, :dependent => :destroy
	has_many :locations, through: :policy_locations, :source => :location
	has_many :policy_reviews
	has_one  :publish_policy
	has_many :policy_approvals
	has_many :attachments, as: :attachable

	accepts_nested_attributes_for :policy_locations, reject_if: lambda { |a| a[:user_id].blank? },:allow_destroy => true
	
end
