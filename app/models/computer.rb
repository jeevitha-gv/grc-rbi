class Computer < ActiveRecord::Base

  has_one :asset , as: :assetable

  # Assosciations
  belongs_to :computer_category
  belongs_to :asset_status
  belongs_to :vendor
  belongs_to :contract
  belongs_to :operating_system


  # Validations
  # validates_presence_of :serial

  accepts_nested_attributes_for :asset
 

  # after_create :send_computer


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_from_file(file, company, user)
    spreadsheet = Computer.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)
      computer_category = ComputerCategory.where("lower(name) = ?", "#{row_data[16].to_s.strip.downcase}").first
      asset_status = AssetStatus.where("lower(name) = ?", "#{row_data[17].to_s.strip.downcase}").first      
      vendor = Vendor.for_name_by_company(row_data[30].to_s.strip.downcase,company.id).last
      contract = Contract.for_name_by_company(row_data[31].to_s.strip.downcase,company.id).first
      operating_system = OperatingSystem.where("lower(name) = ?", "#{row_data[18].to_s.strip.downcase}").first
      owner =  User.for_users_by_company(row_data[2].to_s.strip.downcase, company.id).last
      custodian = User.for_users_by_company(row_data[3].to_s.strip.downcase, company.id).last
      evaluated_by =  User.for_users_by_company(row_data[4].to_s.strip.downcase, company.id).last
      classification = Classification.where("lower(name) = ?", "#{row_data[11].to_s.strip.downcase}").first
      confidentiality = Priority.where("lower(name) = ?", "#{row_data[5].to_s.strip.downcase}").first
      availability = Priority.where("lower(name) = ?", "#{row_data[6].to_s.strip.downcase}").first
      integrity = Priority.where("lower(name) = ?", "#{row_data[7].to_s.strip.downcase}").first
      location = Location.for_name_by_company(row_data[13].to_s.strip.downcase,company.id).last
      department = Department.for_name_by_company(row_data[12].to_s.strip.downcase,company.id).last
      computer = Computer.new(:serial => row_data[14], :ip => row_data[15], :computer_category_id => computer_category.present? ? computer_category.id : nil, :asset_status_id => asset_status.present? ? asset_status.id : nil, :operating_system_id => operating_system.present? ? operating_system.id : nil, :os_ver_ser => row_data[19], :memory => row_data[20], :disk_space => row_data[21], :cpu_speed => row_data[22], :cpu_core_count => row_data[23], :mac => row_data[24], :cost => row_data[25], :acquisition_date => row_data[26], :expiry_date => row_data[27], :last_audit_date => row_data[28], :assigned_on => row_data[29], :vendor_id => vendor.present? ? vendor.id : nil, :contract_id => contract.present? ? contract.id : nil)
      computer.save(:validate => false)
      a = Asset.new(:assetable_id => computer.id, :assetable_type => "Computer", :name => row_data[0], :description => row_data[1], :owner_id => owner.present? ? owner.id : nil, :custodian_id => custodian.present? ? custodian.id : nil, :evaluated_by => evaluated_by.present? ? evaluated_by.id : nil,  :confidentiality => confidentiality.present? ? confidentiality.id : nil, :availability => availability.present? ? availability.id : nil, :integrity => integrity.present? ? integrity.id : nil, :personal_data => row_data[8], :sensitive_data => row_data[9], :customer_data => row_data[10], :classification_id => classification.present? ? classification.id : nil, :department_id => department.present? ? department.id : nil, :location_id => location.present? ? location.id : nil, :company_id => company.id, :identifier_id => user.id)
      a.save
    end
  end

  # def send_computer
  #       users_email = []
  #       users_email << (self.computertechnical_contact.email if self.technical_contact.present?) << (self.computerasset_owner.email if self.asset_owner.present?)
  #       users_email.each_with_index do |email, index|
  #           # RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
  #       AssetMailer.notify_computer(self,email).deliver
  #       end
  # end

  
end
