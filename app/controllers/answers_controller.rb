class AnswersController < ApplicationController

  before_filter :check_for_current_audit
  before_filter :authorize_auditees, :only => [:new]
  before_filter :authorize_auditees_skip_company_admin, :only => [:new]

  def new
    @audit = current_audit
    @current_auditee_nc_questions = @audit.nc_questions.where(:auditee_id => current_user.id)
  end

  def create
    params[:answer] && params[:answer].each do |nc_id, answer|
      attachment = answer["attachment"]
      answer.delete("attachment")
      nc = NcQuestion.where(:id=> nc_id).last
    if nc.answer.nil?
      nc.answer = Answer.new(answer)
      if params[:commit] == "Submit Answers to Auditor"
        nc.is_answered = true
        nc.save
        if attachment.present?
          nc.answer.attachments.build(attachment_file: attachment)
          nc.answer.save
        end
      end
    else
      nc.answer.attachment = nc.answer.attachment.nil? ? nc.answer.attachment = Attachment.new : nc.answer.attachment
      nc.answer.attachment.update(:attachment_file => attachment) if attachment.present?
      nc.answer.update(answer)
    end
  end
    redirect_to new_answers_path
  end

end
