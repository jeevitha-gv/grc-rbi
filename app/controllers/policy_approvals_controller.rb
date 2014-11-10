class PolicyApprovalsController < ApplicationController
	layout 'policy_layout'
	before_filter :current_policy

	def new
		@policy_approve = @policy.policy_approvals.build
	end

	def create

		@policy_approve = @policy.policy_approvals.build(policy_approve_params)
		binding.pry
		@policy_approve.approver = current_user.id
		if @policy_approve.save
			flash[:notice] = "Policy is approved successfully"
			redirect_to policies_path
		else
			render "new"
		end
	end
	def edit
		@policy_approve = @policy.policy_approvals
	end


	def update
		@policy_approve = @policy.policy_approvals
		# risk_status = params[:mgmt_review][:review_id].to_i == 1 ? RiskStatus.where("name= ?", "Reviewed").first.id : RiskStatus.where("name= ?", "Rejected").first.id
		if @policy_approve.update(policy_approve_params)
			flash[:notice] = "Policy is updated successfully"
			redirect_to edit_policy_policy_approve_path
		else
			render "edit"
		end
	end


	private
		def policy_approve_params
			params.require(:policy_approval).permit(:approver, :approval_action_id, comment_attributes: [:id, :comment])
		end

end
