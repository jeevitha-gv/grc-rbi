class PublishPoliciesController < ApplicationController
	layout 'policy_layout'
	before_filter :current_policy

	def new
		# @publish_policy = @policy.publish_policy.present? ? @policy.publish_policy : @policy.build_publish_policy
		if(@policy.publish_policy.present?)
      		redirect_to edit_policy_publish_policy_path(@policy, id: @policy.publish_policy.id)
    	else
      		@publish_policy = @policy.build_publish_policy
    	end
	end

	def create
		@publish_policy = @policy.build_publish_policy(publish_params)
		if @publish_policy.save
			@policy.update(policy_status_id: 7)
			email_call
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
			email_call
			redirect_to policies_path
		else
			render 'edit'
		end
	end

	private

		def email_call
			@user = Policy.find_by_sql("SELECT email_ids FROM publish_distribution_lists INNER JOIN publish_policies ON publish_policies.id = publish_distribution_lists.publish_policy_id INNER JOIN distribution_lists ON distribution_lists.id = publish_distribution_lists.distribution_list_id")
			@users = Policy.find_by_sql("SELECT email FROM publish_policies INNER JOIN publish_emails ON publish_emails.publish_policy_id = publish_policies.id")
			 ReminderMailer.registration_confirmation(@user).deliver
			 ReminderMailer.registration_confirmations(@users).deliver
		end
		
		def publish_params
			params.require(:publish_policy).permit(:subject, :body, publish_emails_attributes: [:id, :email,:_destroy], publish_distribution_lists_attributes: [:id, :distribution_list_id,:_destroy])
		end
end