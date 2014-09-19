class Computer < ActiveRecord::Base

  has_one :asset , as: :assetable

  # Assosciations
  belongs_to :computer_category
  belongs_to :asset_status
  belongs_to :vendor
  belongs_to :contract
  belongs_to :operating_system


  # Validations
  validates_presence_of :serial

  accepts_nested_attributes_for :asset
 

  # after_create :send_computer


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
      vendor = Vendor.for_name_by_company(row_data[].to_s.strip.downcase,company_id).last
      location = Location.for_name_by_company(row_data[6].to_s.strip.downcase,company.id).last
      department = Department.for_name_by_company(row_data[7].to_s.strip.downcase,company.id).last
      technical_contact = User.for_users_by_company(row_data[8].to_s.strip.downcase, company.id).last
      asset_owner = User.for_users_by_company(row_data[9].to_s.strip.downcase, company.id).last
      computer = Computer.new(:name => row_data[0], :serial => row_data[1], :manufacturer => row_data[2], :ip => row_data[3], :computer_category_id => computer_category.present? ? computer_category.id : nil, :asset_status_id => asset_status.present? ? asset_status.id : nil, :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :technical_contact => technical_contact.present? ? technical_contact.id : nil, :asset_owner => asset_owner.present? ? asset_owner.id : nil, :company_id => company.id)
      computer.save(:validate => false)

    end
  end

  def send_computer
        users_email = []
        users_email << (self.computertechnical_contact.email if self.technical_contact.present?) << (self.computerasset_owner.email if self.asset_owner.present?)
        users_email.each_with_index do |email, index|
            # RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
        AssetMailer.notify_computer(self,email).deliver
        end
  end

  
end
