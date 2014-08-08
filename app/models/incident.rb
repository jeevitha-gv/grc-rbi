class Incident < ActiveRecord::Base

	belongs_to :request_type
	belongs_to :incident_category
	belongs_to :sub_category
	belongs_to :department
	belongs_to :team
	has_one :evaluate
	has_one :resolution


	validates :Jobtitle, presence:true, length: { in: 0..50 }
	validates :Jobtitle, uniqueness:true
	#validates_form_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
	validates :title, length: { maximum: 250 }, :if => Proc.new{|f| !f.title.blank? }
	validates :request_type_id, presence:true
	validates :incident_category_id, presence:true
	validates :sub_category_id, presence:true
	validates :date_occured, presence:true
	validates :summary, length: { maximum: 250 }, :if => Proc.new{|f| !f.summary.blank? }
	validates :department_id, presence:true
	validates :incident_status_id, presence:true
	validates :comment, length: { maximum: 250 }, :if => Proc.new{|f| !f.comment.blank? }
	validates_numericality_of :contact_no, :if => Proc.new{|f| !f.contact_no.blank? }
  	validates :contact_no, length: { is: 10},:if => Proc.new{|f| !f.contact_no.blank? }
	validates :team_id, presence:true


end
