class PoliciesController < ApplicationController

	layout 'policy_layout'


	# Index
	def index
	end

	# Method to create a new Policy
	def new
		@policy = Policy.new
	end

	# POST method to create a new policy
	def create
		@policy = Policy.new(policy_params)
		if @policy.save
			redirect_to show_individual_policy_path(@policy)
		else
			render "new"
		end
	end

	# Edit Policy
	def edit
		@policy = Policy.find(params[:id])	
	end

	# Update Policy
	def update 
		@policy = Policy.find(params[:id])
		if @policy.update_attributes(policy_params)
			redirect_to show_individual_policy_path(@policy)
		else
			render "new"
		end
	end

	# Show inidual policy with version management
	def show_individual
		@policy = Policy.find(params[:id])
		@versions = @policy.versions
    	@policy = @policy.versions[params[:version].to_i].reify if params[:version]
	end

	# Will be used for PDF
	def show
		@policy = Policy.find(params[:id])		
	end

	private

	# parameters
	def policy_params
		params.require(:policy).permit(:title,:policy_kind_id,:audience_id,:policy_classification_id, :scope, :purpose, :description, :note,:standard_id, :effective_from, :effective_till, :expected_publish_date, :review_within_date)
	end



end
