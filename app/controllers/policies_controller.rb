class PoliciesController < ApplicationController

	layout 'policy_layout'


	# Index
	def index
		@policies = Policy.all
	end

	# Method to create a new Policy
	def new
		@policy = Policy.new
	end

	# POST method to create a new policy
	def create
		@policy = current_company.policies.build(policy_params)
		binding.pry
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
		respond_to do |format|
			format.pdf do
        		@pdf = (render_to_string pdf: "PDF", template: "policies/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        		send_data(@pdf, type: "application/pdf", filename: @policy.policy_unique_id, disposition: "inline")
      		end
		end
	end


	private

	# parameters
	def policy_params
		params.require(:policy).permit(:title,:policy_kind_id,:audience_id,:policy_classification_id, :scope, :purpose, :description, :owner, :note,:standard_id, :effective_from, :effective_till, :expected_publish_date, :review_within_date, policy_locations_attributes: [:id, :location_id, :_destroy], policy_departments_attributes: [:id, :department_id, :_destroy] , policy_approvers_attributes: [:id, :user_id, :_destroy], policy_reviewers_attributes: [:id, :user_id, :_destroy])
	end



end
