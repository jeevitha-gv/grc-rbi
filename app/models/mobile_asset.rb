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

  def self.import_from_file(file, company)
    spreadsheet = MobileAsset.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)
      device_type = DeviceType.where("lower(name) = ?", "#{row_data[6].to_s.strip.downcase}").first

      location = Location.for_name_by_company(row_data[7].to_s.strip.downcase,company.id).last
      department = Department.for_name_by_company(row_data[8].to_s.strip.downcase,company.id).last
      mobile_asset = MobileAsset.new(:model => row_data[0], :manufacturer => row_data[1], :serial_number => row_data[2], :service_provider => row_data[3], :imei => row_data[4], :description => row_data[5], :device_type_id => device_type.present? ? device_type.id : nil, :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :company_id => company.id)

	  mobile_asset.save(:validate => false)

    end
  end


end
