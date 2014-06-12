class Department < ActiveRecord::Base
  # associations
  has_many :audits
  has_many :teams, :dependent => :destroy
  belongs_to :location

  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i,:if => Proc.new{|f| !f.name.blank? }
  validates :name, length: { maximum: 50 }, :if => Proc.new{|f| !f.name.blank? }
  validates :location_id, presence:true
end
