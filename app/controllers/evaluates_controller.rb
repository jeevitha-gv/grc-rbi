class EvaluatesController < ApplicationController
  def index
  	@evaluates = current_user.evaluates
  end

def new
    @evaluate = Evaluate.new
  end

  def create
  	@evaluate = current_company.evaluates.new(evaluate_params)
  	
  	if @evaluate.save
  		redirect_to evaluates_path
  	else
  		redirect_to new_evaluate_path
  	end
	end

end
