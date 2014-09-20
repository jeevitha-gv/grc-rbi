class InformationAsset < ActiveRecord::Base
	has_one :asset , as: :assetable
	belongs_to :company
	

	accepts_nested_attributes_for :asset

def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
end

	def self.import_from_file(file, company)
    spreadsheet = InformationAsset.open_spreadsheet(file)
    start = 2
    (start..spreadsheet.last_row).each do |i|
      row_data = spreadsheet.row(i)

      information_asset = InformationAsset.new(:at_origin => row_data[14], :info_moved => row_data[15],:retention_period => row_data[16])
      information_asset.save(:validate => false)
      a = Asset.new(:assetable_id => information_asset.id, :assetable_type => "InformationAsset", :name => row_data[0],:description => row_data[1], :confidentiality => row_data[5],:availability => row_data[6], :integrity => row_data[7],:owner_id => row_data[2],:custodian_id => row_data[3], :evaluated_by => row_data[4], :personal_data => row_data[8], :sensitive_data => row_data[9], :customer_data => row_data[10],:classification_id => row_data[11],:department_id => row_data[12],:location_id => row_data[13])
      a.save      
      
    end
  end

end
