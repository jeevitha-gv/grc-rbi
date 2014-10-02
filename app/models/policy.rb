class Policy < ActiveRecord::Base


	# Papertrail
		has_paper_trail
	
	# Associations
		belongs_to :company
		belongs_to :policy_kind
		belongs_to :audience
		belongs_to :policy_classification
		belongs_to :department
		belongs_to :standard, class_name: "Compliance", foreign_key: 'standard_id'
		belongs_to :company_control
		belongs_to :policy_owner, class_name: "User", foreign_key: 'owner'
		belongs_to :policy_status

		has_many :policy_locations, :dependent => :destroy
		has_many :policy_departments, :dependent => :destroy
		has_many :locations, through: :policy_locations, :source => :location
		has_many :departments, through: :policy_departments, :source => :department
		has_many :policy_reviews
		has_one  :publish_policy
		has_many :policy_approvals
		has_many :attachments, as: :attachable
		has_many :policy_reviewers
		has_many :policy_approvers

	# Validations
	  	validates :title, length: { in: 0..250 }, :if => Proc.new{ |f| !f.title.blank? }
	  	validates :title, uniqueness: true, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.title.blank? }
	  	validates :policy_kind_id, presence: true
	  	validates :audience_id, presence: true
	  	validates :policy_classification_id, presence:true
	 	validates :scope, presence: true
	 	validates :purpose, presence: true
		validates :description, presence: true
		validates :standard_id, presence: true
	 	validates :note, length: { in: 0..250 }
	 	validates :owner, presence: true
	  	validates :effective_from, presence: true
	  	validates :effective_till, presence: true
	  	validates :expected_publish_date, presence: true
	  	validate  :check_location_uniqueness
	  	validate  :check_department_uniqueness
	  	validate  :check_location_presence
	  	validate  :check_department_presence
	  	# validate  :check_reviewer_uniquesness

	# Delegation
    	delegate :name, to: :policy_classification, prefix: true, allow_nil: true
    	delegate :name, to: :audience, prefix: true, allow_nil: true
    	delegate :name, to: :policy_kind, prefix: true, allow_nil: true
    	delegate :user_name, to: :policy_owner, prefix: true, allow_nil: true

    # Nested Attributes
  		accepts_nested_attributes_for :policy_locations, reject_if: lambda { |a| a[:location_id].blank? },:allow_destroy => true
  		accepts_nested_attributes_for :policy_departments, reject_if: lambda { |a| a[:department_id].blank? },:allow_destroy => true
  		accepts_nested_attributes_for :policy_reviewers, reject_if: lambda { |a| a[:reviewer].blank? },:allow_destroy => true
  		accepts_nested_attributes_for :policy_approvers, reject_if: lambda { |a| a[:approver].blank? },:allow_destroy => true

	private


	# Method for validating the uniqueness of location
	def check_location_uniqueness
      if self.policy_locations.present?
        check_location_id = policy_locations.size == policy_locations.collect{|x| x.location_id}.uniq.size
        errors.add(:location_id, ("Please select unique location")) if(check_location_id == false)
      end
    end

    # Method for Checking the presence of location
     def check_location_presence
      self.errors[:location_id] = "Choose the locations(s)" unless policy_locations.present?
    end

    # Method for validating the uniqueness of department
	def check_department_uniqueness
      if self.policy_departments.present?
        check_department_id = policy_departments.size == policy_departments.collect{|x| x.department_id}.uniq.size
        errors.add(:department_id, ("Please select unique department")) if(check_department_id == false)
      end
    end

     # Method for Checking the presence of location
    def check_department_presence
      self.errors[:department_id] = "Choose the department(s)" unless policy_departments.present?
    end
	

end
