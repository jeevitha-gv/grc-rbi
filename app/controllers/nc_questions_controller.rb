class NcQuestionsController < ApplicationController

	def new
		@nc_question = NcQuestion.new
	end

end
