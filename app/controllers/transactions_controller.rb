class TransactionsController < ApplicationController
 skip_before_filter :authenticate_user!

def new
  @transaction = Transaction.new
end


def create
  @company =Company.where("domain =?",params[:transaction][:company_domain]).first
  subscribe = Subscription.where("name = ?",params[:transaction][:subscription]).first
  #@payment = CompanyPayment.create(:company_id => @company.id)
  @transaction = Transaction.create(transaction_params)
  @transaction.update_attributes(:company_id => @company.id,:subscription_id=>subscribe.id)
  @transaction.ip_address=request.remote_ip

  if @transaction.save
    if @transaction.purchase
      notify_payment_success     
      redirect_to welcome_path
    else
      SubscriptionNotifier.payment_failed(user_email,@transaction).deliver
      render :action => "failure"
    end
  else
    @trans_param = params
    render :action => 'new'
  end
end

def notify_payment_success
  @transaction.update_attributes(:pay_complete => true)
  user = @company.users
  user_email = user.map(&:email) if user.map(&:role_title).join(",").eql?("company_admin")   
    subscribe = Subscription.where("id = ?",@transaction.subscription_id).first         
     plan = Plan.new(subscription_id: subscribe.id ,company_id: @company.id,starts: @company.created_at ,expires: calculate_plan_expiration(subscribe.valid_log,@company.created_at))
     plan.save!
     @transaction.update_attributes(plan_start: plan.starts,plan_expire: plan.expires)         
   SubscriptionNotifier.payment_complete(user_email,@transaction).deliver if @transaction.pay_complete
end

def transaction_params
  params.require(:transaction).permit(:first_name,:last_name,:card_type,:card_number,:card_verification,:card_expires_on,:company_domain, :subscription)
end
 
end