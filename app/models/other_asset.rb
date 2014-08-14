class OtherAsset < ActiveRecord::Base


	# Associations
	belongs_to :company
	belongs_to :asset_status
	belongs_to :asset_type
	belongs_to :otherasset_owner, class_name: 'User', foreign_key: 'asset_owner'
	belongs_to :otherasset_user, class_name: 'User', foreign_key: 'asset_user'
	belongs_to :location
	belongs_to :department
	belongs_to :maintenance, class_name: 'Contract', foreign_key: 'maintenance_contract'
	belongs_to :lease, class_name: 'Contract', foreign_key: 'lease_contract'
	has_many :lifecycles
    has_one :attachment, as: :attachable

	# Validations
	validates_presence_of :name
	validates_presence_of :manufacturer
	validates_presence_of :asset_type_id
	validates_presence_of :asset_status_id

    accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }


	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when '.csv' then Roo::CSV.new(file.path)
    	when '.xlsx' then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
  	end

  	def self.import_from_file(file, company)
    spreadsheet = OtherAsset.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
	    row_data = spreadsheet.row(i)
    	asset_type = AssetType.for_type_by_company(row_data[2].to_s.strip.downcase, company.id).last
    	asset_status = AssetStatus.where("lower(name) = ?", "#{row_data[3].to_s.strip.downcase}").first
    	asset_owner =  User.for_users_by_company(row_data[9].to_s.strip.downcase, company.id).last
    	asset_user = User.for_users_by_company(row_data[10].to_s.strip.downcase, company.id).last
    	location = Location.for_name_by_company(row_data[11].to_s.strip.downcase,company.id).last
    	department = Department.for_name_by_company(row_data[12].to_s.strip.downcase,company.id).last
    	maintenance_contract = Contract.for_name_by_company(row_data[13].to_s.strip.downcase, company.id, 4).last
    	lease_contract = Contract.for_name_by_company(row_data[14].to_s.strip.downcase, company.id, 3).last
    	other_asset = OtherAsset.new(:name => row_data[0], :manufacturer => row_data[1], :asset_type_id => asset_type.present? ? asset_type.id : nil, :asset_status_id => asset_status.present? ? asset_status.id : nil, :model => row_data[4], :serial_number => row_data[5], :asset_id => row_data[6], :ip => row_data[7], :description => row_data[8], :asset_owner => asset_owner.present? ? asset_owner.id : nil, :asset_user => asset_user.present? ? asset_user.id : nil, :location_id => location.present? ? location.id : nil, :department_id => department.present? ? department.id : nil, :maintenance_contract => maintenance_contract.present? ? maintenance_contract.id : nil, :lease_contract => lease_contract.present? ? lease_contract.id : nil, :company_id => company.id)
    	other_asset.save(:validate => false)
    	end
  	end

    after_create :send_notification
    

    def send_notification
        users_email = []
        users_email << (self.otherasset_owner.email if self.asset_owner.present?) << (self.otherasset_user.email if self.asset_user.present?)
        users_email.each_with_index do |email, index|
            # RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
        AssetMailer.notify(self,email).deliver
    end
    end

    

end
