class Vendor < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :reseller_type
  has_many :softwares
  has_many :computers

 scope :vendor_name, ->(id) { where(id: id).first.name}
 scope :for_name_by_company, lambda {|vendor_name, company_id| where("lower(name)=? and company_id=?", vendor_name, company_id)}


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_from_file(file, company)
    spreadsheet = Vendor.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)

      reseller_type = ResellerType.where("lower(name) = ?", "#{row_data[1].to_s.strip.downcase}").first
      vendor= Vendor.new(:name => row_data[0], :reseller_type_id => reseller_type.present? ? reseller_type.id : nil, :contact_name => row_data[2], :contact_email => row_data[3], :contact_phone => row_data[4], :url => row_data[5], :telephone => row_data[6], :address => row_data[7], :city => row_data[8], :state => row_data[9], :zip => row_data[10], :note => row_data[11], :company_id => company.id)
      vendor.save(:validate => false)

    end
  end
  after_create :vendor_notification

  def vendor_notification
        users_email = []
        users_email << (self.contact_email if self.contact_email.present?) 
        users_email.each_with_index do |email, index|
            # RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
        AssetMailer.notify_vendor(self,email).deliver
      end
    end

    
end
