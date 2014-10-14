class OtherAsset < ActiveRecord::Base


	# Associations
    has_one :asset , as: :assetable
	belongs_to :asset_status
	belongs_to :asset_type
	belongs_to :maintenance, class_name: 'Contract', foreign_key: 'maintenance_contract'
	belongs_to :lease, class_name: 'Contract', foreign_key: 'lease_contract'
	has_many :lifecycles
    has_one :attachment, as: :attachable

	# Validations
	
	# validates_presence_of :manufacturer
	# validates_presence_of :asset_type_id
	# validates_presence_of :asset_status_id
    accepts_nested_attributes_for :asset
    accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }
     accepts_nested_attributes_for :lifecycles, :allow_destroy => true


	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when '.csv' then Roo::CSV.new(file.path)
    	when '.xlsx' then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
  	end

  	def self.import_from_file(file, company, user)
    spreadsheet = OtherAsset.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
    	asset_type = AssetType.for_type_by_company(row_data[15].to_s.strip.downcase, company.id).last
    	asset_status = AssetStatus.where("lower(name) = ?", "#{row_data[16].to_s.strip.downcase}").first
        maintenance_contract = Contract.for_name_by_company(row_data[21].to_s.strip.downcase, company.id, 4).last
        lease_contract = Contract.for_name_by_company(row_data[22].to_s.strip.downcase, company.id, 3).last
    	owner =  User.for_users_by_company(row_data[2].to_s.strip.downcase, company.id).last
        custodian = User.for_users_by_company(row_data[3].to_s.strip.downcase, company.id).last
        evaluated_by =  User.for_users_by_company(row_data[4].to_s.strip.downcase, company.id).last
        classification = Classification.where("lower(name) = ?", "#{row_data[11].to_s.strip.downcase}").first
        confidentiality = Priority.where("lower(name) = ?", "#{row_data[5].to_s.strip.downcase}").first
        availability = Priority.where("lower(name) = ?", "#{row_data[6].to_s.strip.downcase}").first
        integrity = Priority.where("lower(name) = ?", "#{row_data[7].to_s.strip.downcase}").first
        location = Location.for_name_by_company(row_data[13].to_s.strip.downcase,company.id).last
    	department = Department.for_name_by_company(row_data[12].to_s.strip.downcase,company.id).last
    	
        other_asset = OtherAsset.new(:manufacturer => row_data[14], :asset_type_id => asset_type.present? ? asset_type.id : nil, :asset_status_id => asset_status.present? ? asset_status.id : nil, :model => row_data[17], :serial_number => row_data[18], :asset_id => row_data[19], :ip => row_data[20], :maintenance_contract => maintenance_contract.present? ? maintenance_contract.id : nil, :lease_contract => lease_contract.present? ? lease_contract.id : nil)
        other_asset.save(:validate => false)
    	a = Asset.new(:assetable_id => other_asset.id, :assetable_type => "OtherAsset", :name => row_data[0], :description => row_data[1], :owner_id => owner.present? ? owner.id : nil, :custodian_id => custodian.present? ? custodian.id : nil, :evaluated_by => evaluated_by.present? ? evaluated_by.id : nil,  :confidentiality => confidentiality.present? ? confidentiality.id : nil, :availability => availability.present? ? availability.id : nil, :integrity => integrity.present? ? integrity.id : nil, :personal_data => row_data[8], :sensitive_data => row_data[9], :customer_data => row_data[10], :classification_id => classification.present? ? classification.id : nil, :department_id => department.present? ? department.id : nil, :location_id => location.present? ? location.id : nil, :company_id => company.id, :identifier_id => user.id)
    	a.save
    	end
  	end


    

end
