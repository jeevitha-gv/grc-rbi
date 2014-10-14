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
    
  	def self.import_from_file(file, company, user)
    spreadsheet = Software.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
	    software_type = SoftwareType.where("lower(name) = ?", "#{row_data[14].to_s.strip.downcase}").first
    	vendor = Vendor.for_name_by_company(row_data[17].to_s.strip.downcase,company.id).last
    	license_type = LicenseType.where("lower(name) = ?", "#{row_data[23].to_s.strip.downcase}").first
    	owner =  User.for_users_by_company(row_data[2].to_s.strip.downcase, company.id).last
        custodian = User.for_users_by_company(row_data[3].to_s.strip.downcase, company.id).last
        evaluated_by =  User.for_users_by_company(row_data[4].to_s.strip.downcase, company.id).last
        classification = Classification.where("lower(name) = ?", "#{row_data[11].to_s.strip.downcase}").first
        confidentiality = Priority.where("lower(name) = ?", "#{row_data[5].to_s.strip.downcase}").first
        availability = Priority.where("lower(name) = ?", "#{row_data[6].to_s.strip.downcase}").first
        integrity = Priority.where("lower(name) = ?", "#{row_data[7].to_s.strip.downcase}").first
        location = Location.for_name_by_company(row_data[13].to_s.strip.downcase,company.id).last
        department = Department.for_name_by_company(row_data[12].to_s.strip.downcase,company.id).last
    	software = Software.new(:software_type_id => software_type.present? ? software_type.id : nil,  :product_name => row_data[15], :manufacturer => row_data[16], :vendor_id => vendor.present? ? vendor.id : nil, :cost => row_data[18],  :installation_date => row_data[19], :license_expiry_date => row_data[20], :license_key => row_data[21], :version =>row_data[22], :license_type_id => license_type.present? ? license_type.id : nil, :installation_path => row_data[24], :last_audit_date => row_data[25], :assigned_on => row_data[26])
    	software.save(:validate => false)
        a = Asset.new(:assetable_id => software.id, :assetable_type => "Software", :name => row_data[0], :description => row_data[1], :owner_id => owner.present? ? owner.id : nil, :custodian_id => custodian.present? ? custodian.id : nil, :evaluated_by => evaluated_by.present? ? evaluated_by.id : nil,  :confidentiality => confidentiality.present? ? confidentiality.id : nil, :availability => availability.present? ? availability.id : nil, :integrity => integrity.present? ? integrity.id : nil, :personal_data => row_data[8], :sensitive_data => row_data[9], :customer_data => row_data[10], :classification_id => classification.present? ? classification.id : nil, :department_id => department.present? ? department.id : nil, :location_id => location.present? ? location.id : nil, :company_id => company.id, :identifier_id => user.id)
        a.save
    	end
  	end
end
