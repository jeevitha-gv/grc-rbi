class AnswersController < ApplicationController

  def new
    @audit = current_audit
  end

  def create
    params[:answer] && params[:answer].each do |nc_id, answer|
      attachment = answer["attachment"]
      answer.delete("attachment")
      nc = NcQuestion.where(:id=> nc_id).last
      nc.answer = Answer.new(answer)
      if params[:commit] == "Submit Answers to Auditor"
        nc.is_answered = true
        nc.save
        if attachment.present?
          nc.answer.attachments.build(attachment_file: attachment)
          nc.answer.save
        end
      end
    end
    redirect_to new_answers_path
  end

end
