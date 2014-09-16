	class Incident < ActiveRecord::Base

		require 'csv'

		def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

	def self.import(file, company)
    spreadsheet = Incident.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)
      
      incident = Incident.new(:Jobtitle => row_data[0], :title => row_data[1], :request_type_id => row_data[2], :incident_category_id => row_data[3], :sub_category_id => row_data[4], :date_occured => row_data[5], :summary => row_data[6], :department_id => row_data[7], :team_id =>  row_data[8], :incident_status_id =>  row_data[9], :comment =>  row_data[10], :contact_no =>  row_data[11], :resolution_id =>  row_data[12],:incident_status_id => IncidentStatus.where(:name=>"New").first.id)
      incident.save(:validate => false)

   
    end
  end

	# def  self.to_csv
	# 	CSV.generate do |csv|
	# 		csv << column_names
	# 		all.each do |company|
	# 			csv << company.attributes.values_at(*column_names)
			
	# 		end
	# 	end
	
		
	# end


def search
  @incident ||= find_incidents
end

private

def find_incidents
  Incident.find(:all, :conditions => conditions)
end

def title_conditions
  ["incidents.name LIKE ?", "%#{title}%"] unless title.blank?
end

def request_type_id_conditions
  ["incidents.request_type_id LIKE ?", "%#{request_type_id}%"] unless department_id.blank?
end
def department_id_conditions
  ["incidents.department_id LIKE ?", "%#{department_id}%"] unless department_id.blank?
end







# def searchs(title)
#   if title
#     find(:all, :conditions => ['title LIKE ?', "%#{title}%"])
#   else
#     find(:all)
#   end
# end


	belongs_to :request_type
	belongs_to :incident_category
	belongs_to :sub_category
	belongs_to :department
	belongs_to :team
	has_one :evaluate
	has_one :resolution
	has_one :close
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
	accepts_nested_attributes_for :close

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


#audit = Incident.new(:Jobtitle => row_data[0], :title => row_data[1], :request_type_id => row_data[2], :incident_category_id => row_data[3], :sub_category_id => row_data[4], :date_occured => row_data[5], :summary => row_data[6], :department_id => row_data[7], :team_id =>  row_data[8], :incident_status_id =>  row_data[9], :comment =>  row_data[10], :contact_no =>  row_data[11], :resolution_id =>  row_data[12])
# def products
#   @incidentss ||= find_incidents
# end

# private

# def find_incidents
#   .find(:all, :conditions => conditions)
# end

# def title_conditions
#   ["incidents.title LIKE ?", "%#{title}%"] unless keywords.blank?
# end

# def incident_category_conditions
#   ["incidents.incident_category_id LIKE ?", "%#{incident_category_id}%"] unless incident_category_id.blank?
# end
# def incident_status_conditions
#   ["incidents.incident_status_id LIKE ?", "%#{incident_status_id}%"] unless incident_status_id.blank?
# end
