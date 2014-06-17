class AnswersController < ApplicationController

  def new
    @audit = current_audit
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
