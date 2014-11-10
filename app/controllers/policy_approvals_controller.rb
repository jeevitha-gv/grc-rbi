class PolicyApprovalsController < ApplicationController
	layout 'policy_layout'
	before_filter :current_policy

	def new
		@policy_approve = @policy.policy_approvals.build
	end

	def create

		@policy_approve = @policy.policy_approvals.build(policy_approve_params)
		@policy_approve.approver = current_user.id
		if @policy_approve.save
			flash[:notice] = "Policy is approved successfully"
			redirect_to policies_path
		else
			render "new"
		end
	end

	def edit
		@policy_approve = @policy.policy_approvals.find(params[:id])
	end

	def update
		@policy_approve = @policy.policy_approvals.find(params[:id])
		if @policy_approve.update(policy_approve_params)
			flash[:notice] = "Policy is updated successfully"
			redirect_to policies_path
		else
			render "edit"
		end
	end


	private
		def policy_approve_params
			params.require(:policy_approval).permit(:approver, :approval_action_id, comment_attributes: [:id, :comment])
		end

end
