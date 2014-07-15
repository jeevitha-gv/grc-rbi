class PlansController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new]
  prepend_before_filter :skip_if_authenticated, only: [ :new]
	def new
		@plan = Plan.new
		@subscriptions = Subscription.all
	end
end