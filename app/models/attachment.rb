require 'file_size_validator'
class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  mount_uploader :attachment_file, AttachmentUploader
  validates :attachment_file, 
        :file_size => { :maximum => 100.megabytes.to_i} 

end
