class ArtifactAnswer < ActiveRecord::Base

# Relationship
 belongs_to :audit_compliance
 belongs_to :artifact
 belongs_to :responsibility , :class_name => "User", foreign_key: 'responsibility_id'
 belongs_to :priority , :class_name => "Priority"
 has_one :comment , as: :commentable
 has_many :attachments, as: :attachable

 accepts_nested_attributes_for :comment, reject_if: lambda { |a| a[:comment].blank? }, allow_destroy: true

  delegate :name, to: :priority, prefix: true, allow_nil: true
  delegate :full_name, to: :responsibility, prefix: true, allow_nil: true
  delegate :name, to: :artifact, prefix: true, allow_nil: true
  delegate :comment, to: :comment, prefix: true, allow_nil: true

  validates :responsibility_id, presence: true
  validates :target_date, presence: true

  def artifact_display_name
  	self.artifact_id ? self.artifact_name : "No Attachments"
  end

  after_create :notify_auditee_about_checklist

  def notify_auditee_about_checklist
    UniversalMailer.notify_auditee_about_checklist(self).deliver
  end


end
