	class Incident < ActiveRecord::Base

	belongs_to :request_type
	belongs_to :incident_category
	belongs_to :sub_category
	belongs_to :department
	belongs_to :team
	has_one :evaluate
	has_one :resolution
	belongs_to :incident_status
    has_one :attachment, as: :attachable
	
	# validates :Jobtitle, presence:true, length: { in: 0..50 }
	# validates :Jobtitle, uniqueness:true
	#validates_form_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
	# validates :title, length: { maximum: 250 }, :if => Proc.new{|f| !f.title.blank? }
	# validates :request_type_id, presence:true
	# validates :incident_category_id, presence:true
	# validates :sub_category_id, presence:true
	# validates :date_occured, presence:true
	# validates :summary, length: { maximum: 250 }, :if => Proc.new{|f| !f.summary.blank? }
	# validates :department_id, presence:true
	# validates :incident_status_id, presence:true
	# validates :comment, length: { maximum: 250 }, :if => Proc.new{|f| !f.comment.blank? }
	# validates_numericality_of :contact_no, :if => Proc.new{|f| !f.contact_no.blank? }
 	# validates :contact_no, length: { is: 10},:if => Proc.new{|f| !f.contact_no.blank? }
	# validates :team_id, presence:true

	accepts_nested_attributes_for :evaluate
	accepts_nested_attributes_for :resolution

    accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }

	delegate :name, :to => :team, prefix: true, allow_nil: true
	delegate :name, :to => :department, prefix: true, allow_nil: true
	delegate :name, :to => :sub_category, prefix: true, allow_nil: true
	delegate :name, :to => :incident_category, prefix: true, allow_nil: true
	delegate :name, :to => :incident_status, prefix: true, allow_nil: true
	delegate :name, :to => :incident_impact, prefix: true, allow_nil: true
	delegate :name, :to => :request_type, prefix: true, allow_nil: true

	def set_incident_status(incident, commit_name)
    incident.incident_status_id = ((commit_name == "Save as Draft") ?  IncidentStatus.for_name("Draft").first.id : IncidentStatus.for_name("New").first.id)
    return incident
  end
  
end
