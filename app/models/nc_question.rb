class NcQuestion < ActiveRecord::Base

	#Assosciations
	belongs_to :question_type
	belongs_to :priority
	belongs_to :company
	belongs_to :auditee, :class_name => "User", foreign_key: :auditee_id
	belongs_to :audit
	has_many :question_options
	has_one :answer
	has_many :checklist_recommendations, as: :checklist
	accepts_nested_attributes_for :question_options, :allow_destroy => true
  has_one :checklist_recommendation, as: :checklist

	#Validations
	validates :question, presence: true
	validates :target_date, presence: true

	def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  after_create :notify_particular_auditees

  def notify_particular_auditees
    UniversalMailer.delay.notify_auditees_that_checklist_is_prepared(self)
  end

end
