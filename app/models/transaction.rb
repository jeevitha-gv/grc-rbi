class Transaction < ActiveRecord::Base
  belongs_to :company
  belongs_to :subscription
 
  def details
    client.details(self.token)
  end
  
  attr_reader :redirect_uri, :popup_uri
  def setup!(return_url, cancel_url)
    response = client.setup(
      payment_request,
      return_url,
      cancel_url,
      pay_on_paypal: true
    )
    self.token = response.token
    self.save!
    @redirect_uri = response.redirect_uri
    @popup_uri = response.popup_uri
    self
  end
  
  def cancel!
    self.canceled = true
    self.save!
    self
  end

  def complete!(payer_id = nil)
      response = client.checkout!(self.token, payer_id, payment_request)
      self.payer_id = payer_id
      self.identifier = response.payment_info.first.transaction_id
    self.completed = true
    self.save!
    self
  end

  def unsubscribe!
    client.renew!(self.identifier, :Cancel)
    self.cancel!
  end
  
    private

      def client
        Paypal::Express::Request.new PAYPAL_CONFIG
      end

      def payment_request
          pay_amount = 1 
          pay_desc = 'Audit Risk Subscription'
        request_attributes =
          item = {
            name: pay_desc,
            description: pay_desc,
            amount: pay_amount,
            currency_code: 'SGD'
          }
        Paypal::Payment::Request.new request_attributes
      end
end