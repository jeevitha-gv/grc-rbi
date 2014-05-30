class Department < ActiveRecord::Base
  # associations
  has_many :audits
  belongs_to :location

  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i,:if => Proc.new{|f| !f.name.blank? }
  validates :location_id, presence:true
end
