class PlansController < ApplicationController
	skip_before_filter :authenticate_user!
	def index

	end
	def new
		@plan = Plan.new
		@subscriptions = Subscription.all
	end
	def create
		@plan = Plan.new(plan_params)
		if @plan.save
			redirect_to "/companies/new"
		else
			render "new"
		end
	end

	def plan_params
		params.permit(:subscription_id)
	end
end
