class AnswersController < ApplicationController

  def new
    @audit = Audit.find_by_id(params[:id])

  end

  def create
    params[:answer] && params[:answer].each do |nc_id, answer|
      nc = NcQuestion.where(:id=> nc_id).last
      nc.answer=Answer.create(answer)
    end
    @audit = Audit.find(params[:audit_id])
    if((@audit.nc_questions.count == @audit.answers.count) && (params[:commit] == "Submit Answers to Auditor"))
      @audit.is_ncq_answered = true
      @audit.save
    end
     redirect_to new_answers_path(:id => @audit.id)
  end


end
