class MobileAsset < ActiveRecord::Base

  # Assosciations

  belongs_to :device_type
  has_one :asset, as: :assetable
  accepts_nested_attributes_for :asset
  
  # Validations
  #validates_presence_of :model
  #validates_presence_of :manufacturer
  #validates_presence_of :serial_number

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_from_file(file, company, user)
    spreadsheet = MobileAsset.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)
      device_type = DeviceType.where("lower(name) = ?", "#{row_data[14].to_s.strip.downcase}").first
      confidentiality = Priority.where("lower(name) = ?", "#{row_data[5].to_s.strip.downcase}").first
      availability = Priority.where("lower(name) = ?", "#{row_data[6].to_s.strip.downcase}").first
      classification = Classification.where("lower(name) = ?", "#{row_data[11].to_s.strip.downcase}").first
      integrity = Priority.where("lower(name) = ?", "#{row_data[7].to_s.strip.downcase}").first
      location = Location.for_name_by_company(row_data[13].to_s.strip.downcase,company.id).last
      department = Department.for_name_by_company(row_data[12].to_s.strip.downcase,company.id).last
      owner = User.for_users_by_company(row_data[2].to_s.strip.downcase,company.id).last
      custodian = User.for_users_by_company(row_data[3].to_s.strip.downcase,company.id).last
      evaluator = User.for_users_by_company(row_data[4].to_s.strip.downcase,company.id).last
      mobile_asset = MobileAsset.new(:model => row_data[15], :manufacturer => row_data[16], :serial_number => row_data[17], :service_provider => row_data[18], :imei => row_data[19], :device_type_id => device_type.present? ? device_type.id : nil )

	  mobile_asset.save(:validate => false)

    a = Asset.new(:assetable_id => mobile_asset.id, :assetable_type => "MobileAsset", :name => row_data[0],:description => row_data[1], :owner_id => owner.present? ? owner.id : nil,:custodian_id => custodian.present? ? custodian.id : nil,:evaluated_by => evaluator.present? ? evaluated_by.id : nil,:confidentiality => confidentiality.present? ? confidentiality.id : nil, :availability => availability.present? ? availability.id : nil, :integrity => integrity.present? ? integrity.id : nil, :personal_data => row_data[8], :sensitive_data => row_data[9], :customer_data => row_data[10], :classification => classification.present? ? classification.id : nil,:location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :company_id => company.id, :identifier_id => user.id)
    a.save      

    end
  end


end
