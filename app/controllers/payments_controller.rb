class PaymentsController < ApplicationController
 skip_before_filter :authenticate_user!
 def show
    @payment = Transaction.where('identifier=?', params[:id]).first
    if @payment.company
       @company=@payment.company
       user = @company.users
       user_email = user.map(&:email) if user.map(&:role_title).join(",").eql?("company_admin")
       if @payment.pay_complete.eql?(true)
         subscribe = Subscription.where("id = ?",@payment.subscription_id).first         
         plan = Plan.new(subscription_id: subscribe.id ,company_id: @company.id,starts: @company.created_at ,expires: calculate_plan_expiration(subscribe.valid_period,subscribe.valid_log,@company.created_at))
         plan.save!
         @payment.update_attributes(plan_start: plan.starts,plan_expire: plan.expires)         
         SubscriptionNotifier.payment_complete(user_email).deliver if @payment.pay_complete        
        respond_to do |format|
          format.html {redirect_to "/welcome", :notice=>"Payment is successfully completed"}
         end
      elsif @payment.pay_complete.eql?(false) && !@payment.payment_cancel.eql?(true)
         SubscriptionNotifier.payment_failed(user_email).deliver
      end
    end
  end
 
  def destroy
    Transaction.where('identifier=?', params[:id]).first.unsubscribe!
    redirect_to root_path, notice: 'Recurring Profile Canceled'
  end

  def success
    handle_callback do |payment|
      payment.complete!(params[:PayerID])
      flash[:notice] = 'Payment Transaction Completed'
      payment_url(payment.identifier)
    end
  end

  def cancel
    handle_callback do |payment|
      payment.cancel!
      flash[:warn] = 'Payment Request Canceled'
      root_url
    end
  end

    private

      def handle_callback
        payment = Transaction.where('token=?', params[:token]).first 
        @redirect_uri = yield payment
          redirect_to @redirect_uri
      end

      def paypal_api_error(e)
        redirect_to root_url, error: e.response.details.collect(&:long_message).join('<br />')
      end
end