class CompanyControl < ActiveRecord::Base

	# Associations
	has_many :policies

	belongs_to :control_classification
	belongs_to :purpose
	belongs_to :control_state
	belongs_to :control_freq
	belongs_to :standard, class_name: "Compliance", foreign_key: :standard_id
	belongs_to :company

	# Validation
	validates :title, presence: true
  	validates :title, uniqueness: true, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.title.blank? }
  	validates :control_classification_id, presence: true
  	validates :purpose_id, presence: true
  	validates :control_state_id, presence: true
  	validates :control_freq_id, presence: true
  	validates :standard_id, presence: true
  	validates :description, presence: true

	# Delegates
	delegate :name, to: :control_state, prefix: true, allow_nil: true


	# Method for exporting as CSV
    def self.to_csv
      CSV.generate do |csv|
        csv << ["Control Title"]
        all.each do |control|
          csv << [control.title]
        end
      end
    end
end
