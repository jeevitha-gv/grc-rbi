class PaymentsController < ApplicationController
 
 def show
    @payment = Transaction.where('identifier=?', params[:id]).first
    if @payment.company
      @company=@payment.company
      #@payment_status=@company.update_attributes(:payment_status =>@payment.completed)
      #UserMailer.invoice_success(@invoice).deliver if @payment.completed
      respond_to do |format|
        format.html {redirect_to company_welcome_path(@company), :notice=>"Payment is successfully completed"}
        #format.json { render :json=>{:header=>{:status=>200}, :notice=>"Your Payment is successfull, awaiting admin's approval", :body=>{:payment=>@payment, :payment_status=>@payment_status}}}
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
