class Software < ActiveRecord::Base
	belongs_to :vendor
    has_one :asset, as: :assetable

	belongs_to :software_type
	belongs_to :license_type
	accepts_nested_attributes_for :asset

	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when '.csv' then Roo::CSV.new(file.path)
    	when '.xlsx' then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
  	end
    
  	def self.import_from_file(file, company)
    spreadsheet = Software.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
	    software_type = SoftwareType.where("lower(name) = ?", "#{row_data[0].to_s.strip.downcase}").first
    	vendor = Vendor.for_name_by_company(row_data[4].to_s.strip.downcase,company.id).last
    	license_type = LicenseType.where("lower(name) = ?", "#{row_data[12].to_s.strip.downcase}").first
    	location = Location.for_name_by_company(row_data[15].to_s.strip.downcase,company.id).last
    	department = Department.for_name_by_company(row_data[16].to_s.strip.downcase,company.id).last
    	asset_manager =  User.for_users_by_company(row_data[17].to_s.strip.downcase, company.id).last
    	asset_user = User.for_users_by_company(row_data[18].to_s.strip.downcase, company.id).last
    	software = Software.new(:software_type_id => software_type.present? ? software_type.id : nil, :description => row_data[1], :product_name => row_data[2], :manufacturer => row_data[3], :vendor_id => vendor.present? ? vendor.id : nil, :cost => row_data[5], :license_years => row_data[6], :license_months => row_data[7], :installation_date => row_data[8], :license_expiry_date => row_data[9], :license_key => row_data[10], :version =>row_data[11], :license_type_id => license_type.present? ? license_type.id : nil, :installation_path => row_data[13], :last_audit_date => row_data[14], :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :asset_manager_id => asset_manager.present? ? asset_manager.id : nil, :asset_user_id => asset_user.present? ? asset_user.id : nil, :assigned_on => row_data[19], :company_id => company.id)
    	software.save(:validate => false)
    	end
  	end
end
