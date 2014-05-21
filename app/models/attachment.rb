class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  mount_uploader :attachment_file, AttachmentUploader
end
