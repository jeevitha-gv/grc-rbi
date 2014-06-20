class AnswersController < ApplicationController

  before_filter :check_for_current_audit
  before_filter :authorize_auditees, :only => [:new]
  before_filter :authorize_auditees_skip_company_admin, :only => [:new]

  # Initialize answer for nc_question belongs to audit
  def new
    @audit = current_audit
    @current_auditee_nc_questions = @audit.nc_questions.for_auditee(current_user.id)
  end

  # Create answer for nc_question belongs to audit
  def create
    Answer.build_answer(params)
    redirect_to new_answers_path
  end

end
