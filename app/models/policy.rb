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
  validates :title,length: { in: 0..250 }, :if => Proc.new{ |f| !f.title.blank? }
  validates_presence_of :title
  validates :policy_kind_id, presence:true
  validates :audience_id, presence:true
  validates :policy_classification_id, presence:true
  # validates_presence_of :location_ids
  # validates_presence_of :department_ids
  validates :scope, presence:true
  validates :purpose, presence:true

  validates :description, presence:true
  validates :note, length: { in: 0..250 }
  validates :standard_id, presence:true
  validates :owner, presence:true
  validates :effective_from, presence:true

  validates :effective_till, presence:true
  validates :expected_publish_date, presence:true
  validates :review_within_date, presence:true
  validates :policy_status_id, presence:true
    
    delegate :name, to: :policy_classification, prefix: true, allow_nil: true
    delegate :name, to: :audience, prefix: true, allow_nil: true
    delegate :name, to: :policy_kind, prefix: true, allow_nil: true
    delegate :user_name, to: :policy_owner, prefix: true, allow_nil: true

  accepts_nested_attributes_for :policy_locations, reject_if: lambda { |a| a[:user_id].blank? },:allow_destroy => true
	
end
