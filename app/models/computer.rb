class Computer < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :computer_category
  belongs_to :asset_status
  belongs_to :location
  belongs_to :department
  belongs_to :computertechnical_contact, class_name: 'User', foreign_key: 'technical_contact'
  belongs_to :computerasset_owner, class_name: 'User', foreign_key: 'asset_owner'


  # Validations
  validates_presence_of :name
  validates_presence_of :serial
  validates_presence_of :manufacturer


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_from_file(file, company)
    spreadsheet = Computer.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)
      computer_category = ComputerCategory.where("lower(name) = ?", "#{row_data[4].to_s.strip.downcase}").first
      asset_status = AssetStatus.where("lower(name) = ?", "#{row_data[5].to_s.strip.downcase}").first
      location = Location.for_name_by_company(row_data[6].to_s.strip.downcase,company.id).last
      department = Department.for_name_by_company(row_data[7].to_s.strip.downcase,company.id).last
      technical_contact = User.for_users_by_company(row_data[8].to_s.strip.downcase, company.id).last
      asset_owner = User.for_users_by_company(row_data[9].to_s.strip.downcase, company.id).last
      computer = Computer.new(:name => row_data[0], :serial => row_data[1], :manufacturer => row_data[2], :ip => row_data[3], :computer_category_id => computer_category.present? ? computer_category.id : nil, :asset_status_id => asset_status.present? ? asset_status.id : nil, :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :technical_contact => technical_contact.present? ? technical_contact.id : nil, :asset_owner => asset_owner.present? ? asset_owner.id : nil, :company_id => company.id)
      computer.save(:validate => false)

    end
  end

  
end
