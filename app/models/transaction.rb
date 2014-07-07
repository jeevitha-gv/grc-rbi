class Transaction < ActiveRecord::Base
  belongs_to :company
  belongs_to :subscription
  validate :validate_card,on: [:create,:make_recurring]
  attr_accessor :company_domain, :subscription

  def purchase
    amount = Subscription.where("id = ?",self.subscription_id).first.try(:amount)
    response = GATEWAY.purchase(amount, credit_card, purchase_options)
    self.update_attributes(token: response.params["transaction_id"])    
    if response.success? 
       make_recurring
    end
   response.success?
  end
 
  private
  
  def purchase_options
    user = self.company.users
    user_name = user.map(&:user_name) if user.map(&:role_title).join(",").eql?("company_admin")
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "Chennai",
        :state    => "TN",
        :country  => "India",
        :zip      => "600083"
      }
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
       errors.add(:base, message)
      end
    end
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

  def make_recurring
   response_recurring=GATEWAY.recurring(1, credit_card,
    :description => "Payment for plan",
    :start_date => Date.tomorrow,
    :period => "Month",
    :frequency => 1)
    self.update_attributes(payer_id: response_recurring.params["profile_id"])
    response_recurring.success?
  end

end