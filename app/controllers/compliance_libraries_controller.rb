class ComplianceLibrariesController < ApplicationController
	
	def index
		@compliance_libraries = ComplianceLibrary.all
	end
	
	def new
		@compliance_libraries = ComplianceLibrary.new
	end
	
	def create
		#~ p compliance_libraries_params
		#~ @compliance_library = ComplianceLibrary.new(compliance_libraries_params)
		#~ @compliance_library.save
		
	end
	
	
	private
	
	def compliance_libraries_params
		params.require(:compliance_library).permit(:name, :is_leap, :parent_id)
	end
	
end
