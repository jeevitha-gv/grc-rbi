class Service < ActiveRecord::Base
    
	belongs_to :service_type
	has_one :asset , as: :assetable
    accepts_nested_attributes_for :asset

	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when '.csv' then Roo::CSV.new(file.path)
    	when '.xlsx' then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
  	end
    
  	def self.import_from_file(file, company)
    spreadsheet = Service.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
	    service_type = ServiceType.where("lower(name) = ?", "#{row_data[1].to_s.strip.downcase}").first
    	location = Location.for_name_by_company(row_data[5].to_s.strip.downcase,company.id).last
    	department = Department.for_name_by_company(row_data[6].to_s.strip.downcase,company.id).last
    	asset_manager =  User.for_users_by_company(row_data[7].to_s.strip.downcase, company.id).last
    	asset_user = User.for_users_by_company(row_data[8].to_s.strip.downcase, company.id).last
    	service = Service.new(:name => row_data[0], :service_type_id => service_type.present? ? service_type.id : nil, :description => row_data[2], :cost => row_data[3], :sla => row_data[4], :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :asset_manager_id => asset_manager.present? ? asset_manager.id : nil, :asset_user_id => asset_user.present? ? asset_user.id : nil, :assigned_on => row_data[9], :company_id => company.id)
    	service.save(:validate => false)
    	end
  	end
end
