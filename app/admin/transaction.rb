ActiveAdmin.register Transaction do
   menu :if => proc{ !current_admin_user.present? }
  config.filters = false

  controller do
    before_filter :check_company_admin, :check_role
    before_filter :check_subdomain
    actions :all, :except => [:edit,:update,:destroy]

    def index
      @transaction = Transaction.where("company_id = ? ",current_company.id).last
    end
    
    def new
      @transaction = Transaction.new
    end

    def create
      company_transaction = Transaction.where("company_id = ? ",current_company.id).last
      credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card])
      if company_transaction.profile_id.present? && credit_card.valid?        
        response = GATEWAY.update_recurring(profile_id: company_transaction.profile_id,credit_card: credit_card)      
        if response.success?
          flash[:notice] = "Your update request has been processed."
          SubscriptionNotifier.recurring_pay_update(current_company)
          redirect_to "/admin/transactions"
        else  
          flash[:notice] = "Your #{response.message}"
          redirect_to "/admin/transactions"
        end
        else
        flash[:notice] = "Please provide valid card details"
        redirect_to "/admin/transactions/new" 
        end
    end

    def cancel_recurring
      company_transaction = Transaction.where("company_id = ? ",current_company.id).last
      response = GATEWAY.cancel_recurring(company_transaction.profile_id)
      if response.success?
        current_company.recurring_cancel = false
        current_company.save
        SubscriptionNotifier.recurring_pay_cancel(current_company)
        redirect_to admin_transactions_path
      else
        flash[:notice] = "Your cancel request has not been processed.Please contact Admin"
        redirect_to admin_transaction_path(id:company_transaction.id)
      end
    end
  end


  index do
    render "index"
  end

  show do 
    render "cancel_recurring"
  end

  form partial: "form"  
end
