class Transaction < ActiveRecord::Base
  belongs_to :company
  belongs_to :subscription
  validate :validate_card,on: :create
  attr_accessor :company_domain, :subscription

  def purchase
    amount = Subscription.where("id = ?",self.subscription_id).first.try(:amount)
    response = GATEWAY.purchase(amount, credit_card, purchase_options)
    self.update_attributes(token: response.params["transaction_id"])    
    response.success?
  end
 
  private
  
  def purchase_options
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
end