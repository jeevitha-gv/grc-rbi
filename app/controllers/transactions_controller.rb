class TransactionsController < ApplicationController
	if Rails.env.production?
		force_ssl :only => [:new,:create]
	end
	skip_before_filter :authenticate_user!
	skip_before_filter :check_subdomain

	def new
		@transaction = Transaction.new
	end

	def create
		company =Company.where("domain =?",params[:transaction][:company_domain]).first
		user = company.users.map(&:email) if company.users.map(&:role_title).join(",").eql?("company_admin")
		user_email = user 
		subscribe = Subscription.where("name = ?",params[:transaction][:subscription]).first
		@credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card]) 
				if @credit_card.valid?
						@transaction = Transaction.new(transaction_params)
						@transaction.update_attributes(:company_id => company.id,:subscription_id=>subscribe.id,:ip_address=>request.remote_ip)
					if @transaction.purchase(subscribe.amount,@credit_card)
						flash[:notice] = "Payment done successfully"
						notify_payment_success(company,subscribe,user_email)     
						redirect_to welcome_path
					else
						flash[:notice] = "Payment failed due to internal error.Please try after some time"
						@transaction.update_attributes(:pay_complete => false)	
						SubscriptionNotifier.payment_failed(user_email,@transaction,subscribe).deliver
						redirect_to "/users/sign_in"				
					end			

				else
					@transaction = Transaction.new
					@trans_param = params
					render :action => 'new'		
				end
	end

	def notify_payment_success(company,subscribe,user_email)
		@transaction.update_attributes(:pay_complete => true)
		company.plan.update_attributes(subscription_id: subscribe.id, starts: company.created_at, expires: calculate_plan_expiration(subscribe.valid_log,company.created_at))
		plan = company.plan
		@transaction.update_attributes(plan_start: plan.starts,plan_expire: plan.expires)         
		SubscriptionNotifier.payment_complete(user_email,@transaction,subscribe).deliver if @transaction.pay_complete
	end

	def transaction_params
		params.require(:transaction).permit(:company_domain, :subscription)
	end
 
end