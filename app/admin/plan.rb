ActiveAdmin.register Plan do
   menu :if => proc{ !current_admin_user.present? }

  actions :all, :except => [:new,:destroy]


  controller do
    actions :all, :except => [:new,:destroy]
    before_filter :check_company_admin, :check_role
    before_filter :check_subdomain

    def scoped_collection
      Plan.where("company_id = ?",current_user.company_id )
    end

  end

   index do
    column "Subscription" do |c|
      Subscription.where("id = ? ",c.subscription_id).map(&:name).join(",")
    end
    column "Amount" do |c|
      Subscription.where("id IN (?)",c.subscription_id).map(&:amount).join(",")
    end
    column "Company" do |c|
      Company.where("id = ?",c.company_id).map(&:name).join(",")
    end    
    column :starts
    column :expires

    actions
  end
 
  show do
    attributes_table do
    row "Subscription" do |c|
      Subscription.where("id = ? ",c.subscription_id).map(&:name).join(",")
    end    
    row "Amount" do |c|
      Subscription.where("id IN (?)",c.subscription_id).map(&:amount).join(",")
    end
    row "Company" do |c|
      Company.where("id = ?",c.company_id).map(&:name).join(",")
    end
    row :starts
    row :expires

    end
  end

end
