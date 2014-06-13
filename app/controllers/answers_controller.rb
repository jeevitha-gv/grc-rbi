class AnswersController < ApplicationController
  def new
    @audit = Audit.find_by_id(params[:id])
  end

  def create

    @audit = Audit.find(params[:audit][:audit_id])
    if @audit.update_attributes(answer_params)
      redirect_to answers_path
    else
      render "new"
    end
  end

  private
  def answer_params
    binding.pry
    # params.require(:audit).permit(answer_attributes: [:value])
  end


end
