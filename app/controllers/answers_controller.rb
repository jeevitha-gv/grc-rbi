class AnswersController < ApplicationController
  def new
    @audit = Audit.find_by_id(params[:id])
    @answers = Answer.new
    @questions = @audit.nc_questions
  end
end
