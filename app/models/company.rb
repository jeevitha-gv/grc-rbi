class Company < ActiveRecord::Base

  has_many :roles
  has_many :locations
  belongs_to :country # Company belongs to a country
  #validates_uniqueness_of :domain # Domain must be unique
  has_many :users

  has_many :attachments, :as => :attachable
<<<<<<< HEAD
  accepts_nested_attributes_for :attachments, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true
=======
  accepts_nested_attributes_for :attachments, :reject_if => lambda { |t| t[:attachment].nil?}, :allow_destroy => true
  accepts_nested_attributes_for :users
>>>>>>> 89a968c4c095e36eaa402c65b32596147d2b42f2
end
