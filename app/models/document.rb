class Document < ActiveRecord::Base

	belongs_to :company
	belongs_to :location
	belongs_to :department
	belongs_to :document_type
	belongs_to :document_status
	belongs_to :document_manager, class_name: 'User', foreign_key: 'asset_manager_id'
	belongs_to :document_user, class_name: 'User', foreign_key: 'asset_user_id'

	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when '.csv' then Roo::CSV.new(file.path)
    	when '.xlsx' then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
  	end

  	def self.import_from_file(file, company)
    spreadsheet = Document.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
	    document_status = DocumentStatus.where("lower(name) = ?", "#{row_data[1].to_s.strip.downcase}").first
	    document_type = DocumentType.where("lower(name) = ?", "#{row_data[2].to_s.strip.downcase}").first
    	location = Location.for_name_by_company(row_data[4].to_s.strip.downcase,company.id).last
    	department = Department.for_name_by_company(row_data[5].to_s.strip.downcase,company.id).last
    	asset_manager =  User.for_users_by_company(row_data[6].to_s.strip.downcase, company.id).last
    	asset_user = User.for_users_by_company(row_data[7].to_s.strip.downcase, company.id).last
    	document = Document.new(:description => row_data[0], :document_status_id => document_status.present? ? document_status.id : nil, :document_type_id => document_type.present? ? document_type.id : nil, :version => row_data[3], :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :asset_manager_id => asset_manager.present? ? asset_manager.id : nil, :asset_user_id => asset_user.present? ? asset_user.id : nil, :assigned_on => row_data[8], :company_id => company.id )
    	document.save(:validate => false)
    	end
  	end
end
