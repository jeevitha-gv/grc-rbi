class AnswersController < ApplicationController

  def new
    @audit = current_audit
  end

  def create
    params[:answer] && params[:answer].each do |nc_id, answer|
      nc = NcQuestion.where(:id=> nc_id).last
      nc.answer = Answer.create(answer)
      if params[:commit] == "Submit Answers to Auditor"
        nc.is_answered = true
        nc.save
      end
    end
    redirect_to new_answers_path
  end


end
