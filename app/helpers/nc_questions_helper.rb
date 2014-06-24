module NcQuestionsHelper

	def nc_library_questions(audit)
		nc_questions = current_company.nc_questions.where(:nc_library => "true") 
		audit_nc_questions = audit.nc_questions.map(&:id) 
		library_questions = nc_questions.where("id NOT IN (?)", audit_nc_questions) 
	end

end
