class PublishPoliciesController < ApplicationController
	layout 'policy_layout'
	before_filter :current_policy

	def new
		@publish_policy = @policy.publish_policy.present? ? @policy.publish_policy : @policy.build_publish_policy
	end

	def create
		@publish_policy = @policy.build_publish_policy(publish_params)
		if @publish_policy.save
			@policy.update(policy_status_id: 7)
			redirect_to policies_path
		else
			render 'new'
		end
	end

	def edit
		@publish_policy = @policy.publish_policy
	end

	def update
		@publish_policy = @policy.publish_policy
		if @publish_policy.update(publish_params)
			@policy.update(policy_status_id: 7)
			redirect_to policies_path
		else
			render 'edit'
		end
	end

	private

		def publish_params
			params.require(:publish_policy).permit(:subject, :body, publish_emails_attributes: [:id, :email,:_destroy], publish_distribution_lists_attributes: [:id, :distribution_list_id,:_destroy])
		end
end